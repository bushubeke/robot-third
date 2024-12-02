*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library     Collections
Library     String
Library     RequestsLibrary
Library     os
Library     urllib3

Variables      ../page/PageObjects.yaml
Variables      ../page/TestData.yaml
Resource       ../Keywords/Common.robot
Resource       ../Keywords/Read_TestData_Keyword.robot
Resource       ../Keywords/Approval.robot

*** Variables ***
${WKD_CRM_TESTDATA}          ${TestData}[WKD_CRM_TESTDATA]
${ServiceDetailsPage}        ${CRMPage}[ServiceDetailsPage]
${Batch}                     ${CRMPage}[Batch]
${OrderSearch}               ${CRMPage}[OrderSearch]
${RefundCredit}              ${CRMPage}[CreditRefund]

*** Variables ***
${WKD_CRM_TESTDATA}          ${TestData}[WKD_CRM_TESTDATA]
${ServiceDetailsPage}        ${CRMPage}[ServiceDetailsPage]
${Batch}                     ${CRMPage}[Batch]
${OrderSearch}               ${CRMPage}[OrderSearch]
${RefundCredit}              ${CRMPage}[CreditRefund]


*** Keywords ***
CHANGE SIM-POSTPAID For EBU
    [Documentation]    CHANGE SIM-POSTPAID
    [Arguments]     ${caseID}  ${dataID}   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
    ${Data}=         Fetch From Excel  ${WKD_CRM_TESTDATA}  Change_SIM  ${caseID}  ${dataID}
    ${REASON}=          getData  ${Data}  REASON
    ${COMMENT}=         getData  ${Data}  COMMENT
    ${SearchDropdown}=  getData  ${Data}  Search Dropdown
    ${FilePath}=        getData  ${Data}  FilePath
    ${DocumentType}=    getData  ${Data}  DocumentType
    ${ebu_msisdn1}=     getData  ${Data}  ServiceID


    Go Back to Home Page
        Search By ID    ${HomePage}[HomeSearchOptionServiceId]  ${ebu_msisdn1}
        Click Item      ${ServiceDetailsPage}[Manageservice]
        Click Item      ${ServiceDetailsPage}[ManageSim]
        Sleep  8s
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Feature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        Execute Javascript   document.querySelector(".mainContent").scrollTop=700;
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        ${DefaultIMSINumber}=  SeleniumLibrary.Get Element Attribute  //input[@id='imsi']   value
        Log To Console   ${DefaultIMSINumber}
        Click Item       ${ServiceDetailsPage}[ChangeSimButton]
        Click Item       ${ServiceDetailsPage}[ICCID1]
        Click Item       ${ServiceDetailsPage}[ICCID2]
        Sleep  6s
        Click Item       ${ServiceDetailsPage}[ICCID1]
        ${NewIMSINumber}=  SeleniumLibrary.Get Element Attribute  ${ServiceDetailsPage}[ICCID1]   value
        Log To Console   ${NewIMSINumber}
        Verify Popup is visible and displayed    ${ServiceDetailsPage}[SIMReserved]
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        Set Dropdown    ${ServiceDetailsPage}[SimChangeReasonDropdown]  ${REASON}
        Set Input       ${ServiceDetailsPage}[SimChangeComment]         ${COMMENT}
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        Sleep  6s
        Click Item      ${ServiceDetailsPage}[NextButton]
        Set Dropdown    ${ServiceDetailsPage}[Documenttype]   ${DocumentType}
        Choose File     ${Batch}[InputFile]       ${FilePath}
        Click Item      ${ServiceDetailsPage}[AddfilesButton]
        Sleep  3s
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
        Click Item      ${ServiceDetailsPage}[SubmitButton]
        Verify Popup is visible and displayed    ${ServiceDetailsPage}[OrderDetailUpdatedPopup]
        Capture Page Screenshot  EMBED
        Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}

#ORDER DETAILS VIEW
#     Click Item      ${Batch}[Home]
#     Click Item      ${OrderSearch}[Ordertab]
#     Click Item      ${OrderSearch}[viewOrder]
#     Verify elements is visible and displayed    ${OrderSearch}[AdvanceSearch]
#     Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     Click Item    ${OrderSearch}[AdvanceSearch]
#     Set Dropdown    ${OrderSearch}[SearchDropdown]    ${SearchDropdown}
#     Set Input       ${RefundCredit}[SetIputServiceID]     ${ebu_msisdn1}
#     Click Item      ${OrderSearch}[StartDate]
#     Click Item      ${OrderSearch}[TodayForEnd]
#     Click Item      ${OrderSearch}[Enddate]
#     Click Item      ${OrderSearch}[TodayForEnd]
#     Click Item      ${OrderSearch}[SearchButton]
#     Order Management Status Verification    In Progress
#     Capture Page Screenshot  EMBED
#     Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
#     ${Service}   Get Text    ${Batch}[GetServiceId]
#     Log To Console   ${Service}
#     Click Item      ${Batch}[OrderDetail]
#     Click Item      ${Batch}[OrderDetailView]
#     Click Item      (//span[contains(text(),'Pending')])[1]
#     Capture Page Screenshot  EMBED
#     Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
#     Click Item      ${Batch}[Cancel]
#     ${OrderID}      Get Text      //tbody/tr[1]/td[1]
#     Log To Console  OrderID: ${OrderID}
#     Set Global Variable   ${OrderID}

#     Vetting Approval    ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
# #ORDER DETAILS VIEW
#     Click Item      ${Batch}[Home]
#     Click Item      ${OrderSearch}[Ordertab]
#     Click Item      ${OrderSearch}[viewOrder]
#     Verify elements is visible and displayed    ${OrderSearch}[AdvanceSearch]
#     Set Dropdown    ${OrderSearch}[SearchDropdown]    ${SearchDropdown}
#     Set Input       //input[@id="orderId"]     ${OrderID}
#     Click Item      ${OrderSearch}[SearchButton]
#     Order Management Status Verification    Completed
#     Capture Page Screenshot  EMBED
#     Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
#     ${Service}   Get Text    ${Batch}[GetServiceId]
#     Log To Console   ${Service}
#     Click Item      ${Batch}[OrderDetail]
#     Click Item      ${Batch}[OrderDetailView]
#     Click Item      //span[normalize-space()='Order Status']
#     Capture Page Screenshot  EMBED
#     Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
#     Click Item    ${Batch}[Cancel]

#     Go Back to Home Page
#     Search By ID    ${HomePage}[HomeSearchOptionServiceId]  ${ebu_msisdn1}
#     Click Item      ${ServiceDetailsPage}[Manageservice]
#     Click Item      ${ServiceDetailsPage}[ManageSim]
#     Sleep  2s
#     FOR    ${i}    IN RANGE    15
#         Sleep  5s
#         Verify elements is visible and displayed    //div[@class='col-md-12']//div[1]//div[2]
#         Click Item   //div[@class='col-md-12']//div[1]//div[2]
#         Wait Until Element Is Visible     //input[@id='imsi']
#         Execute Javascript   document.querySelector(".mainContent").scrollTop=700;
#         ${IMSINumber}=  SeleniumLibrary.Get Element Attribute  //input[@id='imsi']   value
#         Log To Console   ${IMSINumber}
#         Exit For Loop If       "${IMSINumber}" == "${NewIMSINumber}"
#     END
#     Sleep  3s
#     Capture Page Screenshot  EMBED
#     Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
#     Should Be Equal As Strings Verification   ${IMSINumber}  ${NewIMSINumber}
#     #document view in profile level
#     Click Item      (//a[@href="/crm-ui/profile"])[2]
#     Click Item      ${RefundCredit}[ManageProfile]
#     Click Item      //a[@href="/crm-ui/profile/ViewDocument"]
#     Sleep  5s
#     Execute Javascript   document.querySelector(".mainContent").scrollTop=700;
#     Sleep  5s
#     Capture Page Screenshot  EMBED
#     Screenshot Details For Passed Subfeature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}