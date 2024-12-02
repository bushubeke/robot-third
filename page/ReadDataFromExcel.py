import numpy as np
import pandas as pd
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)



def fetch_from_ExcelData(filename, sheetname, TestCase_ID, TestData_ID):
    data = pd.read_excel(filename, sheet_name=sheetname)
    test = data[(data['TestCaseId']==TestCase_ID) & (data['TestDataId'] == TestData_ID)]
    return test

# def getData(Data, Tag):
#     dataSet = Data
#     dataSet = dataSet.fillna('')
#     print(f"#######  {dataSet[Tag]}")
#     if type(dataSet[Tag][0]) != str and dataSet[Tag][0] != 'NaN':
#         dataSet[Tag] = dataSet[Tag].astype(np.int64)
#     else:
#         dataSet[Tag] = dataSet[Tag][0]

#     # dataSet[Tag] = dataSet[Tag].astype('str')
#     return dataSet[Tag].values[0]
def getData(Data, Tag):
    # Fill NaN values with empty strings
    dataSet = Data.fillna('')

    # Print the specific tag column for debugging
    # print(f"#######  {dataSet[Tag]}")

    # Check the type of the first entry in the 'Tag' column
    if type(dataSet.loc[0, Tag]) != str and dataSet.loc[0, Tag] != 'NaN':
        # Convert the entire 'Tag' column to integers
        dataSet[Tag] = dataSet[Tag].astype(np.int64)
    else:
        # If the first entry is a string or NaN, assign the first value to the entire column
        dataSet[Tag] = dataSet.loc[0, Tag]

    # Return the first value of the 'Tag' column
    return dataSet.loc[0, Tag]
