*** Settings ***
Documentation  API Testing in Robot Framework
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${endPoint}          /Prod/next-birthday
${host}              https://lx8ssktxx9.execute-api.eu-west-1.amazonaws.com/

*** Test Cases ***
Do a GET Request and validate the response code
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    [tags]  RegressionValid
    Create Session  mysession  ${host}  verify=true
    ${response}=  GET On Session  mysession  ${endPoint}  params=dateofbirth=1990-10-30&unit=hour
    Status Should Be  200  ${response}

Do a GET Request and validate the response data type
    [documentation]  This test case verifies that the response data of the GET Request should be json,
    [tags]  RegressionValid
    Create Session  mysession  ${host}  verify=true
    ${response}=  GET On Session  mysession  ${endPoint}  params=dateofbirth=1990-10-30&unit=hour
    Status Should Be  200  ${response}
    ##json object is converted to dictionary here, a good json should always be able to convert to dictionary
    ${jsonText}=  Evaluate    json.loads('''${response.text}''')       json
    ${isDict}=  Evaluate     isinstance(${jsontext},(dict))
    Should Be True    ${isDict}

