@echo off
echo Exporting ASU Next Lab Edge AI Config...
echo.

set DEMODIR=%~dp0
set DEMODIR=%DEMODIR:~0,-1%
set LOVABLEDIR=C:\Users\dan\Documents\NextLab\asu-next-lab-edge-ai

REM Get current version
for /f "usebackq delims=" %%a in ("%DEMODIR%\version.txt") do set CURRENT_VERSION=%%a
echo Current version: v%CURRENT_VERSION%
echo.

REM Ask for new version
set /p NEW_VERSION="Enter new version number (or press Enter to keep v%CURRENT_VERSION%): "
if "%NEW_VERSION%"=="" set NEW_VERSION=%CURRENT_VERSION%

echo.
echo [1/6] Pulling latest Lovable source...
cd /d "%LOVABLEDIR%"
git pull

echo [2/6] Building Lovable frontend...
call npm run build -- --outDir "%DEMODIR%\dist"

echo [3/6] Stopping Open WebUI...
docker stop open-webui
timeout /t 2 /nobreak >nul

echo [4/6] Exporting Open WebUI config...
docker run --rm -v open-webui-data:/data -v "%DEMODIR%":/backup alpine sh -c "cd /data && tar czf /backup/open-webui-data.tar.gz --exclude='./chroma' --exclude='./cache' --exclude='./.cache' ."

echo [5/6] Restarting Open WebUI...
docker start open-webui
timeout /t 2 /nobreak >nul

echo [6/6] Pushing to GitHub...
cd /d "%DEMODIR%"
echo %NEW_VERSION%> version.txt
git add .
git commit -m "v%NEW_VERSION% - frontend and config update"
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