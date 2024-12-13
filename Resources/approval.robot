*** Settings ***
Library    SeleniumLibrary

Resource    ../Resources/common_resource.robot
Resource    ../Keywords/Common.robot



*** Keywords ***
Approval Accept
    [Documentation]    Approve Based on OrderID
    [Arguments]   ${OrderID}  ${Screenshot_Case_ID}  ${Screenshot_Data_ID}
    Execute Suite Setup as User
    Login to SSO UI    ${CRM_CREDENTIAL2}[username]  ${CRM_CREDENTIAL2}[password]
    Go To CRM Home Page
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][Approvals]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][Approval]
    Sleep    5s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Input Text       ${CRMPage}[HomePage][ApprovalOrderInput]    ${OrderID}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][ApprovalSearch]
    Sleep    5s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][ApproveActions]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][ApproveAssign]
    Sleep    5s
    # Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][ApproveActions]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][ApproveView]
    sleep  5s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}  Click Element    ${CRMPage}[HomePage][ApproveRelease]
    Sleep  5s   
    Capture Page Screenshot  EMBED
    Screenshot Details For Passed Feature   ${Screenshot_Case_ID}  ${Screenshot_Data_ID}