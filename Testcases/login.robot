*** Settings ***
Library    SeleniumLibrary    run_on_failure=NOTHING
Suite Setup    Set Screenshot Directory    ${Screenshot Directory}

Resource    ../Keywords/CRM_UI_Postpaid_Services.robot

*** Test Cases ***
EN_Postpaid_01 CRM_TC_P_026_Change SIM -Postpaid In Service For EBU
    [Setup]        Execute Suite Setup as User
    [Teardown]     Execute Suite Teardown   TC_001  TD_01
    [Tags]         Service
    Login to SSO UI  ${CRM_CREDENTIAL1}[username]  ${CRM_CREDENTIAL1}[password]
    CHANGE SIM-POSTPAID For EBU  TC_001  TD_01  TC_001  TD_01
