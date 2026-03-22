@echo off
echo Exporting Open WebUI config...
echo.

set DEMODIR=%~dp0
set DEMODIR=%DEMODIR:~0,-1%

echo [1/4] Stopping Open WebUI...
docker stop open-webui
timeout /t 2 /nobreak >nul

echo [2/4] Exporting config...
docker run --rm -v open-webui-data:/data -v "%DEMODIR%":/backup alpine sh -c "cd /data && tar czf /backup/open-webui-data.tar.gz --exclude='./chroma' --exclude='./cache' --exclude='./.cache' ."

echo [3/4] Restarting Open WebUI...
docker start open-webui
timeout /t 2 /nobreak >nul

echo [4/4] Pushing to GitHub...
cd /d "%DEMODIR%"
git add open-webui-data.tar.gz
git commit -m "update open-webui config"
git push

echo.
echo Done - config exported and pushed to GitHub.
echo Recipients can run update.bat to get the latest.
pause