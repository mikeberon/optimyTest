*** Settings ***
Resource        config.robot
Resource        form.robot
Suite Setup                 Test Suite Setup
Suite Teardown              Test Suite Teardown
Documentation               e2e test for Optimy
Test Tags                   e2e

*** Variables ***

*** Test Cases ***
The user should be able to submit a new application
    [Documentation]  Example test using the base URL
    User submits a new application
    User fills out registration form
    Summary should reflect correct values
    Validate and send

 