*** Settings ***
Library       Collections
Library       DateTime
Library       String

Library       RequestsLibrary
Resource    privateVar.robot
*** Variables ***
${base_url}         https://data.tmd.go.th/nwpapi/v1/forecast/

*** Test Cases ***

Get the TMD all houry_data
       [Tags]      API
      Create Session  tmd   ${base_url}
      &{headers}=   CREATE DICTIONARY    accept=application/json    authorization=${token}
      SET GLOBAL VARIABLE   ${headers}
      ${get_response}=   GET ON SESSION    tmd  location/hourly     expected_status=200         headers=${headers}

      Dictionary Should Contain Key     ${get_response.json()}     hourly_data
      Dictionary Should Contain Key     ${get_response.json()}[hourly_data]     min
Get the TMD data with query
     Create Session  tmd   ${base_url}
     ${date}=    get current date
     ${converted}    Convert Date    ${date}    result_format=%Y-%m-%d
     &{headers}=   CREATE DICTIONARY    accept=application/json    authorization=${token}
     &{query}=   CREATE DICTIONARY    province=นครปฐม    amphoe=สามพราน         date=${converted}   hour=8      duration=2
     ${get_response}=   GET ON SESSION    tmd  location/hourly/place    params=${query}     expected_status=200     headers=${headers}
     Dictionary Should Contain Key     ${get_response.json()}     WeatherForecasts
     LOG    ${get_response.json()}




















