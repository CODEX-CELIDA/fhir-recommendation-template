@echo off

REM this script prepares the environment for the CELIDA project

set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%..

echo Downloading CPG-on-EBMonFHIR package
call %SCRIPT_DIR%download-cpg-package.bat || (echo Failed to download CPG-on-EBMonFHIR package & exit /b)

echo Installing SUSHI
npm install -g fsh-sushi || (echo "Failed to install sushi. Do you have nodejs installed (https://nodejs.org/de/download)?" & exit /b)

echo Downloading FHIR validator
curl -L https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar -o validator_cli.jar || (echo Failed to download FHIR validator & exit /b)

echo Downloading IG Publisher
curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o input-cache\publisher.jar || (echo Failed to download IG publisher & exit /b)
