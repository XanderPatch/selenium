*** Settings ***
Documentation       This is basic information about the whole SUITE
Library             SeleniumLibrary

*** Variables ***


*** Test Cases ***
Should be able to add a new customer
    [Documentation]             Basic info about the test
    [Tags]                      1006    Smoke   Contacts
    log                         Starting the test case

    open browser                https://automationplayground.com/crm/   chrome
    wait until page contains    Customers Are Priority One

    click link                  Sign In
    wait until page contains    Login

    input text                  id=email-id     email@test.com
    input text                  id=password     $ecret!
    click button                id=submit-id
    wait until page contains    Our Happy Customers

    click link                  New Customer
    wait until page contains    Add Customer

    input text                  id=EmailAddress     customer@test.com
    input text                  id=FirstName        FirstName
    input text                  id=LastName         LastName
    input text                  id=City             Macau
    select from list by value   id=StateOrRegion    TX
	select radio button         gender              male
	select checkbox             name=promos-name
	scroll element into view     css=#loginform > div > div > div > div > form > button
	click button                Submit
	wait until page contains    Success! New customer added.

	log                         New Customer added successfully

    sleep                       3s
    close browser

*** Keywords ***
