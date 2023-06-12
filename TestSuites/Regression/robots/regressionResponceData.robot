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
Do a GET Request and validate the response code for valid data
    [documentation]  This test case verifies that the response data of the GET Request for different supported units
    [tags]  RegressionDataUnits
    Create Session  mysession  ${host}  verify=true
    FOR  ${units}  IN  ${unitHour}  ${unitDay}  ${unitWeek}  ${unitMonth}
    ${response}=  GET On Session  mysession  ${endPoint}  params=dateofbirth=1990-10-30&unit=${units}
    Status Should Be  200  ${response}
    #match the data roughly and approximately
    Should Contain    ${response.text}  ${units}s
    END

Do a GET Request and validate the response code for valid data (+${diffInDays} From Today)
    [documentation]  TThis test case verifies that the response data of the GET Request for days
    [tags]  RegressionDataPositiveDateDiff
    Create Session  mysession  ${host}  verify=true
    #Get future date (+10 days)
    ${bdate}=   Get Current Date  UTC  +10 days  result_format=%Y-%m-%d
    ${response}=  GET On Session  mysession  ${endPoint}  params=dateofbirth=${bdate}&unit=${unitDay}
    Status Should Be  200  ${response}
    #Match for the exact string
    Should Be Equal As Strings    {"message": "${diffInDays} days left"}  ${response.text}
    Log To Console    ${response.text}

Do a GET Request and validate the response code for valid data (-${diffInDays} From Today)
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    [tags]  RegressionDataPositiveDateDiff
    Create Session  mysession  ${host}  verify=true
    #Get past date (-10 days)
    ${bdate}=   Get Current Date  UTC  -10 days  result_format=%Y-%m-%d
    ${tdate}=   Get Current Date  UTC  result_format=%Y-%m-%d
    ${nextyear}=  Get Current Date  UTC  result_format=%Y
    ${nextyear}=  Evaluate    ${nextyear} +1
    ${leap}=  Evaluate    ${nextyear} % 4
    ${timeleft}=  Subtract Date From Date  ${tdate}  ${bdate}  exclude_millis=True
    ${daysleft}=  Convert Date    ${timeleft}  result_format=%d
    IF  ${Leap} == 0
        ${days}=  Evaluate    366 - ${daysleft} + 1
    ELSE
        ${days}=  Evaluate    365 - ${daysleft} + 1
    END
    ${response}=  GET On Session  mysession  ${endPoint}  params=dateofbirth=${bdate}&unit=${unitDay}
    Status Should Be  200  ${response}
    #Match for the exact string
    Should Be Equal As Strings    {"message": "${days} days left"}  ${response.text}

Do a GET Request and validate the response code for valid data (+${diffInMonths} Months From Today)
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    [tags]  RegressionDataPositiveMonthDiff
    Create Session  mysession  ${host}  verify=true
    #Get future date (+10 months)
    ${days}=  Evaluate    ${diffInMonths} * 30        #assuming standard 30 days in a month logic
    ${bdate}=   Get Current Date  UTC  +${days} days  result_format=%Y-%m-%d
    ${response}=  GET On Session  mysession  ${endPoint}  params=dateofbirth=${bdate}&unit=${unitMonth}
    Status Should Be  200  ${response}
    #Match for the exact string
    Should Be Equal As Strings    {"message": "${diffInMonths} ${unitMonth}s left"}  ${response.text}
    Log To Console    ${response.text}

Do a GET Request and validate the response code for valid data (+${diffInMonths} Weeks From Today)
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    [tags]  RegressionDataPositiveWeekDiff
    Create Session  mysession  ${host}  verify=true
    #Get future date (+10 weeks)
    ${days}=  Evaluate    ${diffInWeeks} * 7
    ${bdate}=   Get Current Date  UTC  +${days} days  result_format=%Y-%m-%d
    ${response}=  GET On Session  mysession  ${endPoint}  params=dateofbirth=${bdate}&unit=${unitWeek}
    Status Should Be  200  ${response}
    #Match for the exact string
    Should Be Equal As Strings    {"message": "${diffInWeeks} ${unitWeek}s left"}  ${response.text}
    Log To Console    ${response.text}
