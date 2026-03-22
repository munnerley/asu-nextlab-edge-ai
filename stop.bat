@echo off
echo Stopping ASU Next Lab Edge AI Demo...
docker stop open-webui
docker stop open-webui-admin
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im ollama.exe >nul 2>&1
echo Done.
pause