# ADJUST_ACCOUNT
*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library     Collections
Library     String
Library     RequestsLibrary
Library     os
Library     urllib3
Library     DateTime

Library        ../page/ReadDataFromExcel.py
Library        ../page/value_libraries.py
Variables      ../page/PageObjects.yaml
Variables      ../page/TestData.yaml
Resource       ../Keywords/Common.robot
Resource       ../Keywords/Read_TestData_Keyword.robot
Resource       ../Keywords/Approval.robot
Resource       ../Resources/common_resource.robot
Resource       ../Resources/approval.robot


*** Variables ***
# ${WKD_CRM_TESTDATA}          ${TestData}[WKD_CRM_TESTDATA]
${WKD_CRM_TESTDATA}          ${TestData}[WKD_CRM_TESTDATA_CSV] 
${ServiceDetailsPage}        ${CRMPage}[ServiceDetailsPage]



*** Keywords ***
Adjust Account For Prepaid CBU
    [Documentation]    Adjust Account For Prepaid CBU
    [Arguments]   ${caseID}  ${dataID}  ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
    ${Data}=            fetch_from_ExcelData  ${WKD_CRM_TESTDATA}  ADJUST_ACCOUNT  ${caseID}  ${dataID}
    ${AdjustType}=      getData  ${Data}  TYPE
    ${ServiceId}=       getData  ${Data}  ServiceID
    ${COMMENT}=         getData  ${Data}  COMMENT
    ${Amount}=          getData  ${Data}  Amount
    


    # Go Back to Home Page
    Search By Mssidn  ${ServiceId}
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Feature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${ServiceDetailsPage}[ServiceFinance]
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${ServiceDetailsPage}[AdjustAccount]
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${ServiceDetailsPage}[ShowMore]
        Sleep    5s
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Feature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        Sleep    10s
        ${pre_balance}=  Get Text  ${ServiceDetailsPage}[MABalance]
        Log  ${pre_balance}
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text       ${ServiceDetailsPage}[AdjustAmount]    ${Amount}
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text       ${ServiceDetailsPage}[AdustComment]    ${COMMENT}
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${ServiceDetailsPage}[AdjustType]
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text       ${ServiceDetailsPage}[IncrementType]  ${AdjustType}
        Press Keys    None    RETURN
        Sleep    1s
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${ServiceDetailsPage}[AdjustSubmit]
        Sleep    3s
        Attach Vetting Doc
        ${ocs_status}=  Get Text  ${ServiceDetailsPage}[OCSStatus]
        Log  ${ocs_status}
        Sleep    10s
        Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${ServiceDetailsPage}[Reload]
        Sleep  5s
        ${after_balance}=  Get Text  ${ServiceDetailsPage}[MABalance]
        Log  ${after_balance}
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Feature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        Go Back To Home Dashboard
        ${curr_order}=  Get Order By Mssidn ID  ${ServiceId}
        Log  ${curr_order}
        Sleep  5s
        # Close All Browsers
        # Sleep    5s
        # Approval Accept    1311933272048279552   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}