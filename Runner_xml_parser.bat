@ECHO OFF
::==============================================================
SET GITHUB_ACCOUNT=IrynaKazantseva
SET WS_DIR=Workspace
SET REPO_NAME=XML_Parsing
SET APP_VERSION=1.1
SET MAIN_CLASS_1=core.DOM_NO_XPATH
SET MAIN_CLASS_2=core.DOM_W_XPATH
SET MAIN_CLASS_3=core.SAX
SET MAIN_CLASS_4=core.StAX
::==============================================================
IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed

GOTO NEXT

:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%REPO_NAME% RMDIR /S /Q C:\%WS_DIR%\%REPO_NAME%
CD C:\%WS_DIR%
git clone https://github.com/%GITHUB_ACCOUNT%/%REPO_NAME%.git
CD %REPO_NAME%
SLEEP 2
CALL mvn package -Dbuild.version="%APP_VERSION%"
CD target
ECHO.
ECHO Executing Java programm ...
java  -cp %REPO_NAME%-%APP_VERSION%.jar  %MAIN_CLASS_1%
java  -cp %REPO_NAME%-%APP_VERSION%.jar  %MAIN_CLASS_2%
java  -cp %REPO_NAME%-%APP_VERSION%.jar  %MAIN_CLASS_3%
java  -cp %REPO_NAME%-%APP_VERSION%.jar  %MAIN_CLASS_4%

GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% is not exists
GOTO END
:END
CD\
