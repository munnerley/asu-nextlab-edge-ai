@echo off
echo Exporting ASU Next Lab Edge AI - Open WebUI Config...
echo.
set DEMODIR=%~dp0
set DEMODIR=%DEMODIR:~0,-1%

REM Get current version
for /f "usebackq delims=" %%a in ("%DEMODIR%\version.txt") do set CURRENT_VERSION=%%a
echo Current version: v%CURRENT_VERSION%
echo.

REM Ask for new version
set /p NEW_VERSION="Enter new version number (or press Enter to keep v%CURRENT_VERSION%): "
if "%NEW_VERSION%"=="" set NEW_VERSION=%CURRENT_VERSION%
echo.

echo [1/4] Stopping Open WebUI...
docker stop open-webui
timeout /t 2 /nobreak >nul

echo [2/4] Exporting Open WebUI config...
docker run --rm -v open-webui-data:/data -v "%DEMODIR%":/backup alpine sh -c "cd /data && tar czf /backup/open-webui-data.tar.gz --exclude='./chroma' --exclude='./cache' --exclude='./.cache' ."

echo [3/4] Restarting Open WebUI...
docker start open-webui
timeout /t 2 /nobreak >nul

echo [4/4] Pushing to GitHub...
cd /d "%DEMODIR%"
echo %NEW_VERSION%> version.txt
git add .
git commit -m "v%NEW_VERSION% - webui config update"
git push
git tag v%NEW_VERSION%
git push origin v%NEW_VERSION%

echo.
echo Done - v%NEW_VERSION% exported, tagged and pushed to GitHub.
echo.
echo NOTE: GitHub cache takes 2-3 minutes to update.
echo Wait a few minutes before testing the version check.
echo Recipients will be prompted to update on next start.bat launch.
pause
