@echo off
setlocal enabledelayedexpansion

set "found=0"
for /f "tokens=1,2" %%a in ('type sushi-config.yaml') do (
  if !found!==1 (
    if /i "%%a"=="version:" (
      set "cpg_version=%%b"
    )
    set "found=0"
  ) else (
    echo %%a | findstr /C:"de.netzwerk-universitaetsmedizin.ebm-cpg:" > nul && set "found=1"
  )
)
if NOT DEFINED cpg_version ( echo Failed to find the version in sushi-config.yaml. Exiting... & exit /b)

echo CPG Version: "%cpg_version%"

set "filename=de.netzwerk-universitaetsmedizin.ebm-cpg-%cpg_version%.tgz"
set "package_url=https://github.com/CEOsys/cpg-on-ebm-on-fhir/releases/download/v%cpg_version%/%filename%"
echo %package_url% || (echo Failed to set package URL. Exiting... & exit /b)

set "cpg_path=%USERPROFILE%\.fhir\packages\de.netzwerk-universitaetsmedizin.ebm-cpg#%cpg_version%"
echo %cpg_path% || (echo Failed to set CPG path. Exiting... & exit /b)

REM Check if directory exists and delete it if it does
IF EXIST %cpg_path% (
    echo Directory exists, deleting...
    rmdir /S /Q %cpg_path% || (echo Failed to delete existing directory. Exiting... & exit /b)
)

mkdir %cpg_path% || (echo Failed to create directory. Exiting... & exit /b)
cd /d %cpg_path% || (echo Failed to change directory. Exiting... & exit /b)

curl -L %package_url% -o %filename% || (echo Failed to download file with curl. Exiting... & exit /b)

REM We use 7zip for extraction as Windows does not have built-in support for tar files
"C:\Program Files\7-Zip\7z.exe" x %filename% -so | "C:\Program Files\7-Zip\7z.exe" x -aoa -si -ttar || (echo Failed to extract file with 7-Zip. Exiting... & exit /b)
del /f %filename% || (echo Failed to delete file. Exiting... & exit /b)

echo Downloaded CPG-on-EBMonFHIR package successfully
