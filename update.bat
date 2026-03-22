@echo off
echo Pulling latest from GitHub...
git pull
echo.
for /f "tokens=*" %%a in (version.txt) do echo Now on version: v%%a
echo.
echo Done - run start.bat to launch.
pause