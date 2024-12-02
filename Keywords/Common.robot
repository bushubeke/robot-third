*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library     Collections
Library     String
Library     base64
Library     CSVLibrary
Library     Process
Library     Collections


Variables    ../page/PageObjects.yaml
Variables    ../page/TestData.yaml
Library      ../page/screenshot_library.py
Library      ../page/ReadDataFromExcel.py
Resource     ../Keywords/Read_TestData_Keyword.robot
Resource     ../Keywords/Approval.robot

*** Variables ***
${Batch}                    ${CRMPage}[Batch]
${Screenshot Directory}     ${TestData}[Screenshot]
${SuccessScreenshot_Doc}    ${TestData}[Success_Screenshot_Doc]
${WKD_CRM_SCREENSHOT}       ${TestData}[WKD_CRM_SCREENSHOT]
${HomePage}                 ${CRMPage}[HomePage]
${OrderSearch}              ${CRMPage}[OrderSearch]
${Failed_Screenshot_Doc}    ${TestData}[Failed_Screenshot_Doc]

${TimeOut}            40s
${Start}              1s
*** Keywords ***

Custom Error Message
    [Arguments]  ${message}
    Fail  ${message}

Verify elements is visible and displayed
    [Documentation]   Keyword to verify locator is enabled and visibled on a page.
    [Arguments]    ${locator}
    ${ElementVisibled}=    Run Keyword And Return Status    wait until element is visible    ${locator}    timeout=40
    Run Keyword If  '${ElementVisibled}' == 'False'  Custom Error Message  Error: Expected Locator Not Visibled ${\n}${\n}(Locator: '${locator}')
    Run Keyword If  '${ElementVisibled}' == 'False'  Close Window

    ${ElementEnabled}=    Run Keyword And Return Status    wait until element is enabled    ${locator}    timeout=40
    Run Keyword If  '${ElementEnabled}' == 'False'  Custom Error Message  Error: Expected Locator Not Enabled ${\n}${\n}(Locator: '${locator}')
    Run Keyword If  '${ElementEnabled}' == 'False'  Close Window

    ${PageContainElement}=    Run Keyword And Return Status     Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     SeleniumLibrary.wait until page contains element    ${locator}
    Run Keyword If  '${PageContainElement}' == 'False'  Custom Error Message  Error: Page Does Not Contain The Locator ${\n}${\n}(Locator: '${locator}')
    Run Keyword If  '${PageContainElement}' == 'False'  Close Window

Click The Element
    [Arguments]     ${locator}
    Verify elements is visible and displayed  ${locator}
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      SeleniumLibrary.click element      ${locator}

Click Item
    [Arguments]     ${locator}
    ${ClickingItemDisplayed}=    Run Keyword And Return Status    Click The Element  ${locator}
    Run Keyword If  '${ClickingItemDisplayed}' != 'True'  Custom Error Message  The specified option is not present or not clickable. Ensure its availability and whether it can be clicked.(Locator: '${locator}')

Go Back to Home Page
    [Documentation]    To Navigate to Home screen of CRM UI
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      Click Item    ${HomePage}[HomeButton]

Set Input Process
    [Arguments]     ${locator}  ${value}
    Click Item  ${locator}
    Run Keyword If  '${value}' == 'nan'  Log To Console  NANACONDITION
    ...  ELSE IF  '${value}' == 'BLANK'  Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      SeleniumLibrary.input text      ${locator}  \
    ...  ELSE  Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      SeleniumLibrary.input text      ${locator}  ${value}

Set Input
    [Arguments]     ${locator}  ${value}
    ${SetInputSuccess}=    Run Keyword And Return Status    Set Input Process    ${locator}  ${value}
    Run Keyword If  '${SetInputSuccess}' != 'True'   Custom Error Message  Error: Unable to locate input field ${\n}${\n}(Locator: '${locator}')
    Run Keyword If  '${SetInputSuccess}' != 'True'   Close Window

Search By ID
    [Arguments]     ${option}  ${id}
    Click Item  ${option}
    Set Input   ${HomePage}[HomeSearchBar]      ${id}
    Click Item  ${HomePage}[HomeSearchButton]

Screenshot Details For Passed Feature
    [Documentation]    Screenshot details for passed with test case id, feature, subfeature
    [Arguments]        ${caseID}  ${dataID}
    ${data}=           Fetch From Excel  ${WKD_CRM_SCREENSHOT}  Screenshot  ${caseID}  ${dataID}
    ${TestCaseId}=     getData  ${data}  TestCase
    ${MainFeature}=    getData  ${data}  MainFeature
    ${SubFeature}=     getData  ${data}  SubFeature
    Save Screenshot In Doc      ${SuccessScreenshot_Doc}    ${Screenshot Directory}/PassedScreenshot/${TestCaseId}/${MainFeature}.png   ${TestCaseId}    ${MainFeature}  ${SubFeature}

Screenshot Details For Passed Subfeature
    [Documentation]    Screenshot Details For Failed without test case id, feature
    [Arguments]        ${caseID}  ${dataID}
    ${data}=           Fetch From Excel  ${WKD_CRM_SCREENSHOT}  Screenshot  ${caseID}  ${dataID}
    ${TestCaseId}=     getData  ${data}  TestCase
    ${MainFeature}=    getData  ${data}  MainFeature
    ${SubFeature}=     getData  ${data}  SubFeature
    Save Screenshot In Doc Without Testcase      ${SuccessScreenshot_Doc}    ${Screenshot Directory}/PassedScreenshot/${TestCaseId}/${MainFeature}.png   ${MainFeature}  ${SubFeature}

Extract Popup Message
    [Arguments]   ${locator}
    ${xpath_expression}=    Set Variable   ${locator}
    ${start}=    Split String    ${xpath_expression}    =
    ${end}=      Split String    ${start[1]}    ]
    ${PopupMessage}=    Set Variable    ${end[0]}
    Set Global Variable    ${PopupMessage}
    Log    Text: ${end[0]}

Verify Popup is visible and displayed
    [Documentation]   Keyword to verify locator is enabled and visibled on a page.
    [Arguments]    ${locator}
    Extract Popup Message  ${locator}
    ${ElementVisibled}=    Run Keyword And Return Status    wait until element is visible    ${locator}    timeout=40
    Run Keyword If  '${ElementVisibled}' == 'False'  Custom Error Message  Expected Popup Not Found "${PopupMessage}" ${\n}${\n}(Locator:${locator})
    Run Keyword If  '${ElementVisibled}' == 'False'  Close Window

    ${ElementEnabled}=    Run Keyword And Return Status    wait until element is enabled    ${locator}    timeout=40
    Run Keyword If  '${ElementEnabled}' == 'False'  Custom Error Message  Expected Popup Not Found "${PopupMessage}" ${\n}${\n}(Locator:${locator})
    Run Keyword If  '${ElementEnabled}' == 'False'  Close Window

    ${PageContainElement}=    Run Keyword And Return Status     Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     SeleniumLibrary.wait until page contains element    ${locator}
    Run Keyword If  '${PageContainElement}' == 'False'  Custom Error Message  Expected Popup Not Found "${PopupMessage}" ${\n}${\n}(Locator:${locator})
    Run Keyword If  '${PageContainElement}' == 'False'  Close Window

Set Dropdown
    [Arguments]     ${dropdown}  ${locator_label}
    Click Item  ${dropdown}
    ${bool}=    Execute Javascript      var a = document.querySelectorAll('input[type=radio]');for(var i=0;i<a.length;i++){if(a[i].checked==true && a[i].nextSibling.innerHTML.trim() === '${locator_label}') return true; else return false;}
    Log To Console  ------------------------
    Log To Console  ${bool}
    Log To Console  ------------------------
    IF    not ${bool}
        ${DropdownValueDisplayed}=    Run Keyword And Return Status     Wait Until Element Is Visible    //label[text()='${locator_label}' and @md='10']   timeout=5
        Run Keyword If  '${DropdownValueDisplayed}' != 'True'   Custom Error Message  Error: Expected dropdown value '${locator_label}' is not present in the dropdown list
        Run Keyword If  '${DropdownValueDisplayed}' != 'True'   Close Window
        ...  ELSE   Click Item  //label[text()='${locator_label}' and @md='10']

    END

Should Be Equal As Strings Verification
    [Documentation]  custom error message for Should Be Equal As Strings Keyword
    [Arguments]     ${actual_value}   ${expected_value}
    Run Keyword If  '${actual_value}' != '${expected_value}'  Custom Error Message  Values do not match. Expected: ${expected_value}, Current: ${actual_value}
    Run Keyword If  '${actual_value}' != '${expected_value}'  Close Window
    Should Be Equal As Strings   ${actual_value}  ${expected_value}

Input Text Verification
   [Arguments]     ${locator}  ${value}
   ${SetInputSuccess}=    Run Keyword And Return Status    Input Text    ${locator}  ${value}
   Run Keyword If  '${SetInputSuccess}' != 'True'   Custom Error Message  Error: Unable to locate input field ${\n}${\n}(Locator: '${locator}')
   Run Keyword If  '${SetInputSuccess}' != 'True'   Close Window

Execute Suite Setup as User
     [Documentation]     Open Browser on Test or preproduction environmenta
     ${BrowserOpened}=    Run Keyword And Return Status       Open Browser    ${CRM}   ${Browser_Name}  ${TestData}[Browser]     options=add_argument("--ignore-certificate-errors")
     Run Keyword If  '${BrowserOpened}' == 'False'  Custom Error Message  Error: Server Unavailability or Internet Connection Issue.
     Run Keyword If  '${BrowserOpened}' == 'False'   Close Window
     Maximize browser window

Screenshot Details For Failed Feature
    [Documentation]    Screenshot Details For Failed with test case id, feature, subfeature
    [Arguments]        ${caseID}  ${dataID}
    ${data}=           Fetch From Excel  ${WKD_CRM_SCREENSHOT}  Screenshot  ${caseID}  ${dataID}
    ${TestCaseId}=     getData  ${data}  TestCase
    ${MainFeature}=    getData  ${data}  MainFeature
    ${SubFeature}=     getData  ${data}  SubFeature
    Save Failed Screenshot In Doc       ${Failed_Screenshot_Doc}    ${Screenshot Directory}/FailedScreenshot/${TestCaseId}/${MainFeature}.png   ${TestCaseId}    ${MainFeature}  ${SubFeature}

Execute Suite Teardown
    [Documentation]     Closes all open browsers and resets the browser cache.
    [Arguments]         ${caseID}  ${dataID}
    #TODO: add other tasks
    ${ServerError_detected}    Run Keyword And Return Status   Page Should Contain Element   //span[text()="Unable to process request Inernal Server Error"]
    Run Keyword If    ${ServerError_detected}     Capture Page Screenshot  EMBED
    Run Keyword If    ${ServerError_detected}     Capture Page Screenshot    ${Screenshot Directory}/FailedScreenshot/ServerError.png
    Run Keyword If  '${ServerError_detected}' == 'True'  Custom Error Message  Unable to process request Inernal Server Error

    ${ServerError_detected}    Run Keyword And Return Status    Page Should Contain    //span[text()="Failed to Call Down Strem System"]
    Run Keyword If    ${ServerError_detected}     Capture Page Screenshot  EMBED
    Run Keyword If    ${ServerError_detected}     Capture Page Screenshot    ${Screenshot Directory}/FailedScreenshot/DownStreamError.png

    ${OperationFailure_detected}    Run Keyword And Return Status    Page Should Contain    //span[text()="Operation Failure, Please Try Again"]
    Run Keyword If    ${OperationFailure_detected}     Capture Page Screenshot  EMBED
    Run Keyword If    ${OperationFailure_detected}     Capture Page Screenshot    ${Screenshot Directory}/FailedScreenshot/OperationFailure.png
    Run Keyword If Test Failed   Capture Page Screenshot  EMBED
    Run Keyword If Test Failed    Screenshot Details For Failed Feature    ${caseID}  ${dataID}
    close all browsers


Should Be Equal Verification
    [Documentation]  custom error message for Should Be Equal keyword
    [Arguments]     ${actual_value}   ${expected_value}
    Run Keyword If  '${actual_value}' != '${expected_value}'  Custom Error Message  Values do not match. Expected: ${expected_value}, Current: ${actual_value}
    Run Keyword If  '${actual_value}' != '${expected_value}'  Close Window
    Should Be Equal  ${actual_value}  ${expected_value}


Should Not Be Equal Verification
    [Documentation]  custom error message for Should Not Be Equal keyword
    [Arguments]      ${receivedValue}   ${expected_value}
    Run Keyword If  '${receivedValue}' == '${expected_value}'  Custom Error Message  Error: Unexpected value received: '${receivedValue}'
    Run Keyword If  '${receivedValue}' == '${expected_value}'  Close Window
    Should Not Be Equal  ${receivedValue}  ${expected_value}

Order Management Status Verification
    [Arguments]    ${Status}
    Verify elements is visible and displayed    ${Batch}[Completestatus]
    Scroll Element Into View    ${Batch}[Completestatus]

    FOR    ${i}    IN RANGE    25
         Sleep  5s
         Click Item      ${OrderSearch}[SearchRefresh]
         Verify elements is visible and displayed     ${Batch}[Completestatus]
         ${Order Status}   SeleniumLibrary.Get Text   ${Batch}[Completestatus]
         Log To Console  ${Order Status}
         IF   "${Order Status}" == "Failed"
            ${FailedOrderID}=  Get Text    //tbody/tr[1]/td[1]
            Log To Console    ${FailedOrderID}
            Set Test Documentation    ${\n}OrderID: "${FailedOrderID}"    \n append=True
            Click Item    ${Batch}[OrderDetail]
            Click Item    ${Batch}[OrderDetailView]
            Verify elements is visible and displayed     //span[contains(text(),'Failed')]
            Scroll Element Into View    //span[contains(text(),'Failed')]
            Capture Page Screenshot   EMBED
            ${StatusReason}=   Get Text    //span[contains(text(),'Failed')]/following::table[1]/tr[3]/td[3]
            Log To Console    Staus Reason:${StatusReason}
            Set Test Message   StatusReason: ${\n}"${StatusReason}"  \n append=True
         END

         Should Not Be Equal Verification    Failed    ${Order Status}
         Should Not Be Equal Verification    Partial-failure  ${Order Status}
         Should Not Be Equal Verification    Invalid    ${Order Status}

         Exit For Loop If       "${Order Status}" == "${Status}"
    END

    Sleep  1s
    Should Be Equal As Strings    ${Order Status}    ${Status}
    Set Test Documentation   Order Status: ${Order Status}  \n append=True
    ${Order ID}   Get Text      //tbody/tr[1]/td[1]
    Log To Console     OrderID: ${Order ID}
    Set Test Message   ${\n}OrderID: ${Order ID}  \n append=True
    Click Item         //tbody/tr[1]/td[1]
