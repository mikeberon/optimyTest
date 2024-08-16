*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    env.py

*** Variables ***
${BASE_URL}                https://qrqck8u5t9co.front.staging.optimy.net/en/
${LOGIN_BUTTON}             css=a.btn.btn-outline-primary[href="/en/user/login/"]
${COOKIES_MODAL}            css=#cookies-label
${COOKIE_CLOSE_BUTTON}      css=#cookie-close
${EMAIL_INPUT}              css=#login-email
${PASSWORD_INPUT}           css=#login-password
${SUBMIT_BUTTON}            css=div.card.card-body button.btn.btn-lg.btn-primary
${SUBMIT_NEW_BUTTON}        css=a.btn.btn-primary.btn-lg.col-md-auto[href="project/new/"]
${IMPLICIT_WAIT}            .5s
*** Keywords ***
Test Suite Setup
    ${config}=        Get Accounts
    ${username}=      Get From Dictionary    ${config}    USERNAME
    ${password}=      Get From Dictionary    ${config}    PASSWORD
    Open Browser      ${BASE_URL}    browser=chrome
    Maximize Browser Window

    Set Selenium Speed    ${IMPLICIT_WAIT}
    Handle Cookies Modal
    User logins to the website             ${username}    ${password}

Test Suite Teardown
    Close Browser
Handle Cookies Modal
    # Check if the cookie modal is visible
    Run Keyword And Ignore Error    Element Should Be Visible    ${COOKIES_MODAL}
    # Check if the close button inside the modal is visible and click it
    Run Keyword And Ignore Error    Click Element    ${COOKIE_CLOSE_BUTTON}

User logins to the website
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Not Visible    ${COOKIES_MODAL}
    Click Element    ${LOGIN_BUTTON}
    Input Text    ${EMAIL_INPUT}    ${username}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Click Element    ${SUBMIT_BUTTON}
    Wait Until Element Is Visible    ${SUBMIT_NEW_BUTTON}



