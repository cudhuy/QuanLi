@echo off
setlocal
set WRAPPER_DIR=%~dp0\.mvn\wrapper
set PROPERTIES_FILE=%WRAPPER_DIR%\maven-wrapper.properties
set WRAPPER_JAR=%WRAPPER_DIR%\maven-wrapper.jar

if not exist "%WRAPPER_JAR%" (
  if not exist "%PROPERTIES_FILE%" (
    echo Missing %PROPERTIES_FILE%
    exit /b 1
  )
  for /f "tokens=2 delims==" %%A in ('findstr /b "wrapperUrl=" "%PROPERTIES_FILE%"') do set WRAPPER_URL=%%A
  if "%WRAPPER_URL%"=="" (
    echo wrapperUrl is not set in %PROPERTIES_FILE%
    exit /b 1
  )
  echo Downloading Maven Wrapper from %WRAPPER_URL%
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%WRAPPER_URL%','%WRAPPER_JAR%')"
)

set JAVA_CMD=%JAVA_HOME%\bin\java
if not exist "%JAVA_CMD%" set JAVA_CMD=java

"%JAVA_CMD%" -jar "%WRAPPER_JAR%" %*
endlocal