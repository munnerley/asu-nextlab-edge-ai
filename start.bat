@echo off
echo ASU Next Lab Edge AI Demo
echo ========================================

REM Version check
for /f "usebackq delims=" %%a in ("version.txt") do set LOCAL_VERSION=%%a
echo Current version: v%LOCAL_VERSION%
echo Checking for updates...
curl.exe -s https://raw.githubusercontent.com/munnerley/asu-nextlab-edge-ai/main/version.txt -o C:\Windows\Temp\ver_check.txt
set /p REMOTE_VERSION=<C:\Windows\Temp\ver_check.txt
del C:\Windows\Temp\ver_check.txt >nul 2>&1
if not "%LOCAL_VERSION%"=="%REMOTE_VERSION%" (
    echo.
    echo New version available: v%REMOTE_VERSION%
    echo.
  set /p UPDATE="Would you like to update now? (Y/N): "
echo You entered: %UPDATE%
if /i "%UPDATE%"=="Y" goto :doupdate
if /i "%UPDATE%"=="y" goto :doupdate
goto :skipupdate

:doupdate
echo Updating...
git pull
echo.
echo Update complete - restarting...
pause
start.bat
exit

:skipupdate
) else (
    echo You are on the latest version.
)


echo.
echo ========================================
echo.

echo Clearing ports if in use...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8888') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000') do taskkill /PID %%a /F >nul 2>&1

echo [0/4] Starting Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
echo Waiting for Docker to be ready...
timeout /t 20 /nobreak >nul

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
timeout /t 10 /nobreak >nul

echo [3/4] Starting Frontend...
set DEMODIR=%~dp0
set DEMODIR=%DEMODIR:~0,-1%
start "" cmd /c "serve "%DEMODIR%\dist" -l 8888"
timeout /t 2 /nobreak >nul

echo [4/4] Starting Demo Proxy...
timeout /t 10 /nobreak >nul
start "" cmd /c "node "%DEMODIR%\proxy.js""
timeout /t 2 /nobreak >nul

echo.
echo All services running:
echo   Frontend      ->  http://localhost:8888
echo   Demo WebUI    ->  http://localhost:3000  (auto-login as demouser)
echo   Admin WebUI   ->  http://localhost:3001  (admin login required)
echo   Version       ->  v%LOCAL_VERSION%
echo.
start http://localhost:8888
pause