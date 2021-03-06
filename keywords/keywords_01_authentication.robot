*** Settings ***

Resource      libraries.robot

*** Variables ***

${URL}        https://the-internet.herokuapp.com/login
${BROWSER}    chrome


*** Keywords ***

###Setup and Teardown Begin
Open navigator
    selenium.Open Browser                     ${URL}
    ...                                       ${BROWSER}
    selenium.Maximize Browser Window
Close navigator
    selenium.Close Browser
###Setup and Teardown End

Login with valid credentials
    [Arguments]                               ${username}
    ...                                       ${password}
    ...                                       ${error_msg}

    selenium.Input Text                       id=username
    ...                                       ${username}

    selenium.Input Password                   id=password
    ...                                       ${password}

    selenium.Click Element                    css=#login > button

    selenium.Wait Until Element Is Visible    id=flash
    ...                                       timeout=15s

    selenium.Element Should Contain           id=flash
    ...                                       ${error_msg}

    selenium.Click Element                    link=Logout

    selenium.Capture Page Screenshot          filename=login_succesful.png

    #removing existing screenshot files from output directory
    system.Remove Files                       ${CURDIR}/../output/login_unsuccesful-1.png
    ...                                       ${CURDIR}/../output/login_unsuccesful-2.png
    ...                                       ${CURDIR}/../output/login_unsuccesful-3.png
    ...                                       ${CURDIR}/../output/login_unsuccesful-4.png
    ...                                       ${CURDIR}/../output/login_unsuccesful-5.png


Login with invalid credentials
    [Arguments]                               ${username}
    ...                                       ${password}
    ...                                       ${error_msg}

    selenium.Input Text                       id=username
    ...                                       ${username}

    selenium.Input Password                   id=password
    ...                                       ${password}

    selenium.Click Element                    css=#login > button

    selenium.Wait Until Element Is Visible    id=flash
    ...                                       timeout=15s

    selenium.Element Should Contain           id=flash
    ...                                       ${error_msg}

    #using {index} in the filename option, the file will not ovwerwritten
    selenium.Capture Page Screenshot          filename=login_unsuccesful-{index}.png







