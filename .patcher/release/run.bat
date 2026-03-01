@echo off
setlocal

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo Running deployment script...
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0hs\hs.ps1"

echo.
if %errorlevel% neq 0 (
    echo Deployment failed. Error code: %errorlevel%
) else (
    echo Deployment finished successfully.
)

echo.
pause
