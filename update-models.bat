@echo off
echo Updating Ollama models...
echo.
echo [1/2] Checking qwen2.5:7b...
ollama pull qwen2.5:7b
echo.
echo [2/2] Checking translategemma...
ollama pull translategemma
echo.
echo All models up to date.
pause