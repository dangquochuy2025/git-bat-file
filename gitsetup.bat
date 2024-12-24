@echo off
set GitDownloadURL=https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.1/Git-2.47.1-64-bit.exe
set GitInstallerTemp=%TEMP%\GitSetup.exe
echo Downloading Git from the server, please wait...
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%GitDownloadURL%' -OutFile '%GitInstallerTemp%'"
if not exist %GitInstallerTemp% (
    echo Download failed. Please check your network connection.
    pause
    exit /b
)
echo Installing Git...
%GitInstallerTemp% /SILENT /NORESTART
del /F /Q %GitInstallerTemp%
echo Git has been successfully installed!
pause
