*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library     Collections
Library     String
Library     base64
Library     CSVLibrary
Library     Process
Library     Collections


Library      ../page/screenshot_library.py
Variables    ../page/PageObjects.yaml
Variables    ../page/TestData.yaml
Resource     ../Keywords/Read_TestData_Keyword.robot
Resource     ../Keywords/SSO_Login_Keyword.robot
Resource     ../Keywords/Common.robot
Resource     ../Keywords/CRM_UI_Postpaid_Services.robot


*** Variables ***
${HomePage}         ${CRMPage}[HomePage]
${OrderSearch}      ${CRMPage}[OrderSearch]
${Vetting}          ${CRMPage}[Vetting]
${Attach}           ${TestData}[WKD_CRM_ATTACHFILE]
${SSO}              ${WKD}[SSOPage]
${Selector}         ${WKD}[HomePageDropDown]
${TimeOut}          60s
${Start}            1s
${CRM_CREDENTIAL2}          ${TestData}[USER][crm_user2]

*** Keywords ***
Go To CRM Home Page
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${SSO}[crm_2]
    Switch Window    new
    Sleep    15s

Go Back To Home Dashboard
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${HomePage}[HomeButton]


Search By Mssidn
    [Arguments]  ${SearchValue}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Go To CRM Home Page
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Selector}[drop_down]
    Click Element    ${Selector}[drop_down]
    Sleep    1s
    Click Element    ${Selector}[search_mssidn]
    Click Element    ${Selector}[drop_down]
    Sleep    1s
    Input Text    ${Selector}[input_selector]    ${SearchValue}
    Click Button    ${Selector}[search_button]
    Sleep    5s   

Search By Iccid
    [Arguments]  ${SearchValue}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Go To CRM Home Page
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Selector}[drop_down]
    Sleep    1s
    Click Element    ${Selector}[search_iccid]
    Click Element    ${Selector}[drop_down]
    Sleep    1s
    Input Text    ${Selector}[input_selector]    ${SearchValue}
    Click Button    ${Selector}[search_button]
    Sleep    5s


Search By ID
    Go To CRM Home Page


Search By Account ID
    [Arguments]  ${SearchValue}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Go To CRM Home Page
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Selector}[drop_down]
    Sleep    1s
    Click Element    ${Selector}[search_account]
    Click Element    ${Selector}[drop_down]
    Sleep    1s
    Input Text    ${Selector}[input_selector]    ${SearchValue}
    Click Button    ${Selector}[search_button]
    Sleep    5s

Search By profile ID
    [Arguments]  ${SearchValue}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Go To CRM Home Page
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Selector}[drop_down]
    Sleep    1s
    Click Element    ${Selector}[search_profile]
    Click Element    ${Selector}[drop_down]
    Sleep    1s
    Input Text    ${Selector}[input_selector]    ${SearchValue}
    Click Button    ${Selector}[search_button]
    Sleep    5s


Get Order By Mssidn ID
    [Arguments]  ${SearchValue}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[OrderPage]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[AdvancedOrder]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text  ${OrderSearch}[OrderServiceInput]    ${SearchValue}
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[OrderSearchButton]
    Sleep    5s
    ${current_order}=  Get Text    ${OrderSearch}[OrderIDNumber]
    RETURN  ${current_order}


Get Order By Account ID
    [Arguments]  ${SearchValue}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[OrderPage]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[AdvancedOrder]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text  ${OrderSearch}[OrderAccountInput]    ${SearchValue}
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[OrderSearchButton]
    Sleep    5s
    ${current_order}=  Get Text    ${OrderSearch}[OrderIDNumber]
    RETURN  ${current_order}


Get Order By Profile ID
    [Arguments]  ${SearchValue}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[OrderPage]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[AdvancedOrder]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text  ${OrderSearch}[OrderProfileInput]    ${SearchValue}
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${OrderSearch}[OrderSearchButton]
    Sleep    5s
    ${current_order}=  Get Text    ${OrderSearch}[OrderIDNumber]
    RETURN  ${current_order}


Attach Vetting Doc
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Vetting}[SelectClick]
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text    ${Vetting}[VettingSelect]     Application
    Press Keys    None    RETURN
    # wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Vetting}[BrowseOption] 
    Log   ${Attach}
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Choose File   ${Vetting}[FileInput]     ${Attach}
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Vetting}[AddFile]
    Sleep    3s
    wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${Vetting}[FinalSubmit]                                                                                            
    Sleep    2s