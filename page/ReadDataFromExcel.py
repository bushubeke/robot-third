import numpy as np
import pandas as pd
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)



def fetch_from_ExcelData(filename, sheetname, TestCase_ID, TestData_ID):
     # Read the Excel file into a DataFrame
    data = pd.read_excel(filename, sheet_name=sheetname)

    # Filter the data based on the TestCase_ID and TestData_ID
    test = data[(data['TestCaseId'] == TestCase_ID) & (data['TestDataId'] == TestData_ID)]
    
    #  changing the filter data to dictionary
    test =test.to_dict(orient='records')
        
    #  check if value of datafarme changed to dictionary has been found 
    # return empty test dictionary  if it does not exist or return the first dictionary value
    if len(test) > 0:
        return test[0]
    else:
        return {}
   

def fetch_from_CSVData(filename, sheetname, TestCase_ID, TestData_ID):
     # Read the Excel file into a DataFrame
    data = pd.read_csv(filename, encoding='latin-1', on_bad_lines='skip')

    #  filtering test data from datafarme using testcaseid and testid
    test = data[(data['TestCaseId'] == TestCase_ID) & (data['TestDataId'] == TestData_ID)]
    
    #  changing the filter data to dictionary
    test =test.to_dict(orient='records')
    
    #  check if value of datafarme changed to dictionary has been found 
    # return empty test dictionary  if it does not exist or return the first dictionary value 
    if len(test) > 0:
        return test[0]
    else:
        return {}


def getData(Data, Tag):
    # returning key value from dictionary if it exists and return not there if value does not exist
    return Data.get(Tag, "Not there")
