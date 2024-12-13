*** Settings ***
Library    SeleniumLibrary    run_on_failure=NOTHING
Suite Setup    Set Screenshot Directory    ${Screenshot Directory}

Resource    ../Keywords/CRM_UI_Postpaid_Services.robot
Resource    ../Resources/common_resource.robot
Resource    ../Resources/prepaid.robot
Resource    ../Resources/approval.robot


*** Test Cases ***
Basic Building Template Area
    [Setup]        Execute Suite Setup as User
    [Teardown]     Execute Suite Teardown   TC_001  TD_01
    [Tags]     Prepaid_trail    
    Login to SSO UI  ${CRM_CREDENTIAL1}[username]  ${CRM_CREDENTIAL1}[password]
    Adjust Account For Prepaid CBU  TC_002  TD_04  TC_002  TD_04
    # Approval Accept    1311933272048279552