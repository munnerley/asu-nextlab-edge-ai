@echo off
echo Stopping ASU Next Lab Edge AI Demo...
docker stop open-webui
taskkill /f /im node.exe >nul 2>&1
echo Done.
pause