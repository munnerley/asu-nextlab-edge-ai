@echo off
echo Starting ASU Next Lab Edge AI Demo...
echo.

echo Clearing ports if in use...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8888') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000') do taskkill /PID %%a /F >nul 2>&1

echo [1/4] Starting Ollama...
set OLLAMA_HOST=0.0.0.0
start "" /min "%LOCALAPPDATA%\Programs\Ollama\ollama.exe" serve
timeout /t 5 /nobreak >nul

echo [2/4] Starting Open WebUI...
docker start open-webui 2>nul
if %errorlevel% neq 0 (
    echo First run - restoring configuration...
    docker run --rm -v open-webui-data:/data -v %cd%:/backup alpine tar xzf /backup/open-webui-data.tar.gz -C /data
    echo Creating demo container...
    docker run -d --name open-webui --restart always -p 3002:8080 -v open-webui-data:/app/backend/data -e OLLAMA_BASE_URL=http://host.docker.internal:11434 -e WEBUI_AUTH=True -e WEBUI_AUTH_TRUSTED_EMAIL_HEADER=X-User-Email -e WEBUI_NAME="ASU Next Lab Edge AI" ghcr.io/open-webui/open-webui:main
    echo Creating admin container...
    docker run -d --name open-webui-admin --restart always -p 3001:8080 -v open-webui-data:/app/backend/data -e OLLAMA_BASE_URL=http://host.docker.internal:11434 -e WEBUI_AUTH=True -e WEBUI_NAME="ASU Next Lab Edge AI Admin" ghcr.io/open-webui/open-webui:main
) else (
    docker start open-webui-admin 2>nul
)
timeout /t 5 /nobreak >nul

echo [3/4] Starting Frontend...
start "" /min cmd /k "serve "%~dp0dist" -l 8888"
timeout /t 2 /nobreak >nul

echo [4/4] Starting Demo Proxy...
start "" /min cmd /k "cd /d "%~dp0" && node proxy.js"
timeout /t 2 /nobreak >nul

echo.
echo All services running:
echo   Frontend      ->  http://localhost:8888
echo   Demo WebUI    ->  http://localhost:3000  (auto-login as demouser)
echo   Admin WebUI   ->  http://localhost:3001  (admin login required)
echo.
start http://localhost:8888
pause