*** Settings ***


Library     OperatingSystem
Library     SeleniumLibrary
Library     Collections
Library     String

Library      ../page/ReadDataFromExcel.py

*** Variables ***

*** Keywords ***
# Fetch From Excel
#     [Arguments]  ${filename}  ${sheetname}  ${TestCaseID}  ${TestDataID}
#     ${celldata}=  fetch_from_ExcelData  ${filename}  ${sheetname}  ${TestCaseID}  ${TestDataID}
#     [Return]  ${celldata}
# Fetch data from an Excel file for a given TestCaseID and TestDataID
Fetch From Excel
    [Arguments]  ${filename}  ${sheetname}  ${TestCaseID}  ${TestDataID}
    
    # Fetch cell data using the custom library function
    ${celldata}=  fetch_from_ExcelData  ${filename}  ${sheetname}  ${TestCaseID}  ${TestDataID}
    
    # Optional: Add checks to handle situations where data is not found
    Run Keyword If  '${celldata}' == ''  Fail  Data not found for TestCaseID: ${TestCaseID} and TestDataID: ${TestDataID}
    
    # Return the cell data
    [Return]  ${celldata}