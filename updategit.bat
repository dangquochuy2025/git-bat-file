@echo off
set GitReleasesAPI=https://api.github.com/repos/git-for-windows/git/releases/latest
set GitInstallerTemp=%TEMP%\GitSetup.exe

echo Checking for the latest Git version...
for /f "tokens=2 delims=:, " %%A in ('powershell -Command "(Invoke-WebRequest -Uri 'https://api.github.com/repos/git-for-windows/git/releases/latest' -UseBasicParsing).Content | ConvertFrom-Json | Select-Object -ExpandProperty assets | Select-Object -ExpandProperty browser_download_url | Where-Object {$_ -match '64-bit.exe'}"') do set GitDownloadURL=%%A

if "%GitDownloadURL%"=="" (
    echo Failed to fetch the latest Git version. Please check your network connection.
    pause
    exit /b
)

echo Downloading the latest Git version...
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%GitDownloadURL%' -OutFile '%GitInstallerTemp%'"
if not exist %GitInstallerTemp% (
    echo Download failed. Please check your network connection.
    pause
    exit /b
)

echo Installing the latest Git version...
%GitInstallerTemp% /SILENT /NORESTART
del /F /Q %GitInstallerTemp%
echo Git has been successfully updated to the latest version!
pause
