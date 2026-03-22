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

REM Check Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Installing] Node.js...
    winget install --id OpenJS.NodeJS.LTS -e --source winget --silent
) else (
    echo [OK] Node.js already installed
)

REM Check Docker Desktop
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Installing] Docker Desktop...
    winget install --id Docker.DockerDesktop -e --source winget --silent
    echo Docker Desktop installed - you may need to restart your computer after this.
) else (
    echo [OK] Docker already installed
)

REM Check Ollama
ollama --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Installing] Ollama...
    winget install --id Ollama.Ollama -e --source winget --silent
    echo [OK] Ollama installed - you may need to restart your computer
) else (
    where ollama >nul 2>&1
    if %errorlevel% neq 0 (
        echo [Installing] Ollama not in PATH - reinstalling...
        winget install --id Ollama.Ollama -e --source winget --silent --force
    ) else (
        echo [OK] Ollama already installed
    )
)
REM Install serve globally
echo.
echo Installing serve...
npm install -g serve >nul 2>&1
echo [OK] serve installed

REM Install Node dependencies
echo Installing Node dependencies...
npm install >nul 2>&1
echo [OK] Node dependencies installed

REM Pull AI model
echo.
echo Checking AI model...
ollama list 2>nul | findstr "qwen2.5:7b" >nul
if %errorlevel% equ 0 (
    echo [OK] Model already downloaded
) else (
    echo Pulling AI model (this may take a while - 4.7GB download)...
    ollama pull qwen2.5:7b
    if %errorlevel% neq 0 (
        echo WARNING: Model download failed.
        echo Please run 'ollama pull qwen2.5:7b' manually after setup.
    ) else (
        echo [OK] Model ready
    )
)
ollama pull qwen2.5:7b
if %errorlevel% neq 0 (
    echo WARNING: Model download failed. 
    echo Please run 'ollama pull qwen2.5:7b' manually after setup.
) else (
    echo [OK] Model ready
)

echo.
echo ========================================
echo Setup complete! 
echo.
echo If Docker Desktop was just installed,
echo please restart your computer first,
echo then double-click start.bat
echo ========================================
pause