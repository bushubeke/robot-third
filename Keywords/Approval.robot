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
${Approval}                 ${CRMPage}[Approval]
${CRM}                      ${TestData}[URL]
${Browser_Name}             ${TestData}[Browser]
${Screenshot Directory}     ${TestData}[Screenshot]
${CRM_CREDENTIAL2}          ${TestData}[USER][crm_user2]

*** Keywords ***
Vetting Approval
    [Arguments]     ${screenshot_case_id}    ${screenshot_data_id}
    #Approval
    Click Item    ${HomePage}[HomeButton]
    Click Item    ${Approval}[Approvals]
    Click Item    ${HomePage}[Approval History]
    Verify elements is visible and displayed    ${Batch}[InputOrder]
    Input Text Verification    ${Batch}[InputOrder]    ${OrderID}
    Click Item       ${Batch}[SearchButton]
    Click Item      ${Batch}[OrderGetText]
    Sleep  2s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    ${order}  Get Text    ${Batch}[OrderGetText]
    Should Be Equal Verification   ${order}   ${OrderID}
    Click Item    (//button[contains(@aria-label,'Details')])[1]
    Verify elements is visible and displayed    //a[normalize-space()='Next >']
    Sleep  4s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    Execute Javascript   document.querySelector(".mainContent").scrollTop=1000;
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    Click Item         //a[normalize-space()='Next >']
    Execute Javascript   document.querySelector(".mainContent").scrollTop=1000;
    Sleep  1s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    Close All Browsers

    Open Browser    ${CRM}   ${Browser_Name}   options=add_argument("--ignore-certificate-errors")
    Maximize browser window
    Login to SSO UI  ${CRM_CREDENTIAL2}[username]  ${CRM_CREDENTIAL2}[password]
    #Approval
    Click Item    ${HomePage}[HomeButton]
    Click Item    ${Approval}[Approvals]
    Click Item    ${Approval}[ClickApproval]
    Verify elements is visible and displayed    ${HomePage}[Approval Type Dropdown]
    Set Dropdown   ${HomePage}[Approval Type Dropdown]    DOCUMENT VETTING APPROVAL
    Input Text Verification    ${Batch}[InputOrder]    ${OrderID}
    Click Item       //button[normalize-space()='Search']
    Click Item      //tbody/tr[1]/td[3]
    ${order}  Get Text    //tbody/tr[1]/td[3]
    Should Be Equal Verification   ${order}   ${OrderID}
    Click Item    (//button[@class='action-btn-popover btn btn-secondary'])[1]
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    Click Item    //button[@aria-label='Self Assign']
    Verify elements is visible and displayed    //span[text()="Approval Assigned to self Successfully"]
    Sleep  2s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}

    Click Item    ${Approval}[View]

#   validation
    Verify elements is visible and displayed    //span[1]//div[1]//div[2]

    Click Item    //div[@class='MuiGrid-root Off-state cursor-pointer MuiGrid-item']
    Execute Javascript   document.querySelector(".mainContent").scrollTop=1000;
    Sleep  2s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}

    Click Item    ${Approval}[ClickApproveButton]
    Set Input     ${RefundCredit}[Comment]    Approve
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature  ${screenshot_case_id}    ${screenshot_data_id}
    Click Item    ${RefundCredit}[Submit]
    Verify elements is visible and displayed    //span[text()="Approve success"]
    Capture Page Screenshot  EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    close all browsers

    Execute Suite Setup as User
    Login to SSO UI  ${CRM_CREDENTIAL1}[username]  ${CRM_CREDENTIAL1}[password]

    #Approval
    Click Item    ${HomePage}[HomeButton]
    Click Item    ${Approval}[Approvals]
    Click Item    ${HomePage}[Approval History]
    Verify elements is visible and displayed    ${Batch}[InputOrder]
    Input Text Verification    ${Batch}[InputOrder]    ${OrderID}
    Click Item       ${Batch}[SearchButton]
    Click Item      ${Batch}[OrderGetText]
    Sleep  2s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    ${order}  Get Text    ${Batch}[OrderGetText]
    Should Be Equal Verification   ${order}   ${OrderID}
    Click Item    (//button[contains(@aria-label,'Details')])[1]
    Click Item    //div[@class='MuiGrid-root Off-state cursor-pointer MuiGrid-item']
    Verify elements is visible and displayed    //a[normalize-space()='Next >']
    Sleep  4s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    Execute Javascript   document.querySelector(".mainContent").scrollTop=1000;
    Sleep  4s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    Click Item         //a[normalize-space()='Next >']
    Execute Javascript   document.querySelector(".mainContent").scrollTop=1000;
    Sleep  1s
    Capture Page Screenshot   EMBED
    Screenshot Details For Passed Subfeature   ${screenshot_case_id}    ${screenshot_data_id}
    Go Back to Home Page
