@echo off
echo Starting ASU Next Lab Edge AI Demo...
echo.

echo [1/3] Starting Ollama...
start "" "%LOCALAPPDATA%\Programs\Ollama\ollama.exe" serve
timeout /t 3 /nobreak >nul

echo [2/3] Starting Open WebUI...
docker start open-webui 2>nul || (
    echo First run - pulling Open WebUI...
    docker run -d ^
      --name open-webui ^
      --restart always ^
      -p 3000:8080 ^
      -v open-webui-data:/app/backend/data ^
      -e OLLAMA_BASE_URL=http://host.docker.internal:11434 ^
      ghcr.io/open-webui/open-webui:main
)
timeout /t 5 /nobreak >nul

echo [3/3] Starting Frontend...
start "" cmd /k "cd /d "%~dp0" && serve dist -p 8888"
timeout /t 2 /nobreak >nul

echo.
echo All services running:
echo   Frontend   ->  http://localhost:8888
echo   Open WebUI ->  http://localhost:3000
echo.
start http://localhost:8080
pause