*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    utils.py

*** Variables ***
${RELATIVE_IMAGE_PATH}      cypress.jpg

${SUBMIT_NEW_LINK}          css=a[class='btn btn-outline-primary']
${SUBMIT_NEW_BUTTON}        css=a.btn.btn-primary.btn-lg.col-md-auto[href="project/new/"]
${PRIMARY_BUTTON}           css=div.page-main__content-wrapper li.card.card-body a.btn.btn-primary
${NEXT_BUTTON}              css=#navButtonNext
#NAME
${FIRST_TXT}                css=input[id='06c8a27e-7d11-57b2-9286-af8fc8ba5b27']
${LAST_TXT}                 css=input[id='9d848df4-cdd0-50aa-820f-fdedcbda7e11']
#ADDRESS
${ADDRESS_TXT}              css=textarea[id='852ff964-97c2-5ea0-9674-49b3f95d2e86::17540589-1aa5-5bf7-93fa-d49acf58b711']

#POSTAL CODE
${POSTAL_TXT}               css=input[name='48b06bb5-8a4f-504e-93a7-2c5e888da553::5911b832-9522-524a-9f3c-8014c2ddba1c']

#COUNTRY
${COUNTRY_SELECT}           css=#bf6f7c7f-1da5-55d7-99ac-2866e4a139fd

${UPLOAD}                   css=input[name='Filedata']  
#GENDER
${MALE_RADIO}               css=label[aria-label='Male'] div[class='custom-control-label radio-checkbox-li-element-label']
${FEMALE_RADIO}             css=label[aria-label='Female'] div[class='custom-control-label radio-checkbox-li-element-label']

#ROLE
${ROLE_SELECT}              css=#field_cba99291-980c-5cb1-91c2-1db8d294587b

#SKLL
${PYTHON_CHK}               css=label[aria-label='Python'] div[class='custom-control-label radio-checkbox-li-element-label']

${AUTO_ROLE}                    97434c3e-1096-529e-ab94-52b48db51ab0
${PH}                           PH
${CAREER}                       css=body
${FIRSTNAME_REFLECTED}          css=#container_06c8a27e-7d11-57b2-9286-af8fc8ba5b27
${LASTNAME_REFLECTED}          css=#container_9d848df4-cdd0-50aa-820f-fdedcbda7e11
${STREET_REFLECTED}            css=#container_17540589-1aa5-5bf7-93fa-d49acf58b711 > p
${POSTAL_REFLECTED}            css=#container_5911b832-9522-524a-9f3c-8014c2ddba1c
${COUNTRY_REFLECTED}            css=#container_bf6f7c7f-1da5-55d7-99ac-2866e4a139fd
${GENDER_REFLECTED}            css=#container_254f1489-f589-50c5-a1cc-698f61546ccc
${ROLE_REFLECTED}            css=.answer.view.mb-0
${SKILL_REFLECTED}            css=#field_73c26bc3-c6fb-5224-b962-b417331ee64c
${CO_REFLECTED}            css=#container_c3a3b516-fbe1-5eb2-90e6-f90c21972e3a > div > div > p


${VALIDATE_AND_SEND}            xpath=(//button[@id='submitButton' and contains(text(), 'Validate and send')])[2]

${FIRSTNAME_DATA}                    Ross
${LASTNAME_DATA}                    Geller
${ADDRESS_DATA}                    2213
${POSTAL_DATA}                    2100 - Deurne
${COUNTRY_DATA}                    Philippines
${GENDER_DATA}                    Male
${ROLE_DATA}                    Automation tester
${SKILL_DATA}                    Python
${CO_DATA}                    THIS IS FOR AUTOMATION TESTING ONLY

${THANK_YOU_MESSAGE}            css=h1[class='h1 text-center']

*** Keywords ***
User submits a new application
    Click Element    ${SUBMIT_NEW_BUTTON}
    # Check if the primary button exists
    Run Keyword And Ignore Error    Element Should Be Visible    ${PRIMARY_BUTTON}
    # Click the "Submit a new application" button if it exists
    Scroll Element Into View    ${SUBMIT_NEW_LINK} 
    Click Element    ${SUBMIT_NEW_LINK} 
    Wait Until Element Is Visible    ${NEXT_BUTTON}

User fills out registration form
    Input Text    locator=${FIRST_TXT}    text=${FIRSTNAME_DATA} 
    Input Text    locator=${LAST_TXT}    text=${LASTNAME_DATA}
    Input Text    locator=${ADDRESS_TXT}    text=${ADDRESS_DATA}
    Input Text    locator=${POSTAL_TXT}    text=2100
    Press Keys    ${POSTAL_TXT}    ARROW_DOWN
    Sleep    1s
    Press Keys    NONE        RETURN
    Sleep    1s
    Press Keys    NONE        TAB
    Select From List By Value    ${COUNTRY_SELECT}        ${PH} 
    Scroll Element Into View    locator=${UPLOAD}
    Choose File    locator=${UPLOAD}     file_path=${CURDIR}/${RELATIVE_IMAGE_PATH}     
    Click Element    ${MALE_RADIO}
    Select From List By Value    ${ROLE_SELECT}        ${AUTO_ROLE}
    Click Element    locator=${PYTHON_CHK} 
    Select Career Objective Frame 
    Input Text    locator=${CAREER}    text=${CO_DATA}
    Unselect Career Objective Frame
    Click Element    css=#navButtonNext

Select Career Objective Frame    
    Select Frame        locator=//iframe[@title='Editor, c3a3b516-fbe1-5eb2-90e6-f90c21972e3a::9aba057d-53de-543a-b8ec-9b8005d1bb1e']

Unselect Career Objective Frame    
    Unselect Frame

Summary should reflect correct values
    Sleep    5s
    Wait Until Element Is Visible       locator=${FIRSTNAME_REFLECTED}
    Validate name
    Validate street
    Validate postal
    Validate country
    Validate gender
    Validate role
    Validate skill
    Validate career objective
    Scroll Element Into View    locator=${VALIDATE_AND_SEND}
    Click Element    locator=${VALIDATE_AND_SEND}

Validate and send
    Sleep    5s
    Wait Until Element Is Visible           ${THANK_YOU_MESSAGE} 
Validate name
    ${FIRSTNAME_DISPLAYED}        Get Text        ${FIRSTNAME_REFLECTED}
    Should Be Equal    ${FIRSTNAME_DISPLAYED}       ${FIRSTNAME_DATA}     
    Log To Console    message=${FIRSTNAME_DISPLAYED} is equal to ${FIRSTNAME_DATA}
    
    ${LASTNAME_DISPLAYED}        Get Text        ${LASTNAME_REFLECTED}
    Should Be Equal    ${LASTNAME_DISPLAYED}       ${LASTNAME_DATA}     
    Log To Console    message=${LASTNAME_DISPLAYED} is equal to ${LASTNAME_DATA}
Validate street
    ${STREET_DISPLAYED}        Get Text        ${STREET_REFLECTED}
    Should Be Equal    ${STREET_DISPLAYED}       ${ADDRESS_DATA}      
    Log To Console    message=${STREET_DISPLAYED} is equal to ${ADDRESS_DATA} 

Validate postal
    ${POSTAL_DISPLAYED}        Get Text        ${POSTAL_REFLECTED}
    Should Be Equal    ${POSTAL_DISPLAYED}       ${POSTAL_DATA}     
    Log To Console    message=${POSTAL_DISPLAYED} is equal to ${POSTAL_DATA} 

Validate country
    ${COUNTRY_DISPLAYED}        Get Text        ${COUNTRY_REFLECTED}
    Should Be Equal    ${COUNTRY_DISPLAYED}       ${COUNTRY_DATA}     
    Log To Console    message=${COUNTRY_DISPLAYED} is equal to ${COUNTRY_DATA} 

Validate gender
    ${GENDER_DISPLAYED}        Get Text        ${GENDER_REFLECTED}
    Should Be Equal    ${GENDER_DISPLAYED}       ${GENDER_DATA}     
    Log To Console    message=${GENDER_DISPLAYED} is equal to ${GENDER_DATA} 

Validate role
    ${ROLE_DISPLAYED}        Get Text        ${ROLE_REFLECTED}
    Should Be Equal    ${ROLE_DISPLAYED}      ${ROLE_DATA}     
    Log To Console    message=${ROLE_DISPLAYED} is equal to ${ROLE_DATA} 

Validate skill
    ${SKILL_DISPLAYED}        Get Text        ${SKILL_REFLECTED}
    Should Be Equal    ${SKILL_DISPLAYED}       ${SKILL_DATA}     
    Log To Console    message=${SKILL_DISPLAYED} is equal to ${SKILL_DATA}
Validate career objective
    ${CO_DISPLAYED}        Get Text        ${CO_REFLECTED}
    Should Be Equal    ${CO_DISPLAYED}       ${CO_DATA}     
    Log To Console    message=${CO_DISPLAYED} is equal to ${CO_DATA}