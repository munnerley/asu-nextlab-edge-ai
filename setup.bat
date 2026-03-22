@echo off
echo ASU Next Lab Edge AI - First Time Setup
echo ========================================
echo.
echo Checking prerequisites...
echo.

REM Check Git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Installing] Git...
    winget install --id Git.Git -e --source winget --silent
) else (
    echo [OK] Git already installed
)
echo CHECKPOINT 1 - Git done

REM Check Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Installing] Node.js...
    winget install --id OpenJS.NodeJS.LTS -e --source winget --silent
) else (
    echo [OK] Node.js already installed
)
echo CHECKPOINT 2 - Node done

REM Check Docker Desktop
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Installing] Docker Desktop...
    winget install --id Docker.DockerDesktop -e --source winget --silent
    echo [OK] Docker Desktop installed - you may need to restart your computer after this.
) else (
    echo [OK] Docker already installed
)
echo CHECKPOINT 3 - Docker done

REM Check Ollama
ollama --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Installing] Ollama...
    winget install --id Ollama.Ollama -e --source winget --silent
    echo [OK] Ollama installed - you may need to restart your computer
) else (
    where ollama >nul 2>&1
    if %errorlevel% neq 0 (
        echo [Reinstalling] Ollama not in PATH - reinstalling...
        winget install --id Ollama.Ollama -e --source winget --silent --force
    ) else (
        echo [OK] Ollama already installed
    )
)
echo CHECKPOINT 4 - Ollama done

REM Install serve globally
echo.
echo Installing serve...
serve --version >nul 2>&1
if %errorlevel% neq 0 (
    call npm install -g serve
) else (
    echo [OK] serve already installed
)
echo Press any key to continue setup...
pause >nul
REM Install Node dependencies
echo Installing Node dependencies...
npm install >nul 2>&1
echo [OK] Node dependencies installed
echo CHECKPOINT 6 - npm install done

REM Start Docker Desktop
echo.
echo Starting Docker Desktop...
if exist "C:\Program Files\Docker\Docker\Docker Desktop.exe" (
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    echo Waiting for Docker to initialize (60 seconds^)...
    timeout /t 60 /nobreak >nul
    echo [OK] Docker Desktop started
) else if exist "%LOCALAPPDATA%\Docker\Docker Desktop.exe" (
    start "" "%LOCALAPPDATA%\Docker\Docker Desktop.exe"
    echo Waiting for Docker to initialize (60 seconds^)...
    timeout /t 60 /nobreak >nul
    echo [OK] Docker Desktop started
) else (
    echo WARNING: Docker Desktop not found - please start it manually before running start.bat
)
echo CHECKPOINT 7 - Docker start done

REM Pull AI model
echo.
echo Checking AI model...
where ollama >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: Ollama not in PATH - skipping model download.
    echo Please restart your computer then run setup.bat again to download the model.
    goto :setupcomplete
)
echo CHECKPOINT 8 - Ollama in PATH
ollama list 2>nul | findstr "qwen2.5:7b" >nul
if %errorlevel% equ 0 (
    echo [OK] Model already downloaded
) else (
    echo Pulling AI model (this may take a while - 4.7GB download^)...
    ollama pull qwen2.5:7b
    if %errorlevel% neq 0 (
        echo WARNING: Model download failed.
        echo Please run 'ollama pull qwen2.5:7b' manually after setup.
    ) else (
        echo [OK] Model ready
    )
)
echo CHECKPOINT 9 - Model done

:setupcomplete
echo.
echo ========================================
echo Setup complete!
echo.
echo If Docker Desktop or Ollama were just installed,
echo please restart your computer first,
echo then double-click start.bat
echo ========================================
pause