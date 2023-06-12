*** Settings ***
Documentation  API Testing in Robot Framework
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library    DateTime

*** Variables ***
${endPoint}          /Prod/next-birthday
${host}              https://lx8ssktxx9.execute-api.eu-west-1.amazonaws.com/
${unitHour}          hour
${unitDay}           day
${unitWeek}          week
${unitMonth}         month
${diffInDays}          10
${diffInMonths}        10
${diffInWeeks}         10


*** Test Cases ***
Do a POST Request and validate the response code for valid data
    [documentation]  This test case verifies that the response code of the POST Request should be 403
    [tags]  RegressionDataUnits
    Create Session  mysession  ${host}  verify=true
    FOR  ${units}  IN  ${unitHour}  ${unitDay}  ${unitWeek}  ${unitMonth}
    ${response}=  Run Keyword And Ignore Error  POST On Session  mysession  ${endPoint}  params=dateofbirth=1990-10-30&unit=${unitDay}
    Status Should Be    403
    END

Do a PUT Request and validate the response code for valid data (+${diffInDays} From Today)
    [documentation]  This test case verifies that the response code of the PUT Request should be 403
    [tags]  RegressionDataPositiveDateDiff
    Create Session  mysession  ${host}  verify=true
    ${bdate}=   Get Current Date  UTC  +10 days  result_format=%Y-%m-%d
    ${response}=  Run Keyword And Ignore Error   PUT On Session  mysession  ${endPoint}  params=dateofbirth=1990-10-30&unit=${unitDay}
    Status Should Be  403

Do a head Request and validate the response code for valid data (+${diffInDays} From Today)
    [documentation]  This test case verifies that the response code of the HEAD Request should be 403
    [tags]  RegressionDataPositiveDateDiff
    Create Session  mysession  ${host}  verify=true
    ${bdate}=   Get Current Date  UTC  +10 days  result_format=%Y-%m-%d
    ${response}=  Run Keyword And Ignore Error   HEAD On Session  mysession  ${endPoint}  params=dateofbirth=1990-10-30&unit=${unitDay}
    Status Should Be  403

Do a delete Request and validate the response code for valid data (+${diffInDays} From Today)
    [documentation]  This test case verifies that the response code of the DELETE Request should be 403
    [tags]  RegressionDataPositiveDateDiff
    Create Session  mysession  ${host}  verify=true
    ${bdate}=   Get Current Date  UTC  +10 days  result_format=%Y-%m-%d
    ${response}=  Run Keyword And Ignore Error   DELETE On Session  mysession  ${endPoint}  params=dateofbirth=1990-10-30&unit=${unitDay}
    Status Should Be  403