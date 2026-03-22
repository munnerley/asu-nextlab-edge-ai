@echo off
echo Starting ASU Next Lab Edge AI Demo...
echo.

echo Clearing port 8888 if in use...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8888') do taskkill /PID %%a /F >nul 2>&1

echo [1/3] Starting Ollama...
start "" "%LOCALAPPDATA%\Programs\Ollama\ollama.exe" serve
timeout /t 3 /nobreak >nul

echo [2/3] Starting Open WebUI...
docker start open-webui 2>nul
if %errorlevel% neq 0 (
    echo First run - restoring configuration...
    docker run --rm -v open-webui-data:/data -v %cd%:/backup alpine tar xzf /backup/open-webui-data.tar.gz -C /data
    echo Creating Open WebUI container...
    docker run -d --name open-webui --restart always -p 3000:8080 -v open-webui-data:/app/backend/data -e OLLAMA_BASE_URL=http://host.docker.internal:11434 -e WEBUI_AUTH=True -e WEBUI_NAME="ASU Next Lab Edge AI" ghcr.io/open-webui/open-webui:main
)
timeout /t 5 /nobreak >nul

echo [3/3] Starting Frontend...
set SCRIPTDIR=%~dp0
start "" cmd /k "cd /d %SCRIPTDIR% && serve dist -p 8888"
timeout /t 2 /nobreak >nul

echo.
echo All services running:
echo   Frontend   ->  http://localhost:8888
echo   Open WebUI ->  http://localhost:3000
echo.
start http://localhost:8888
pause