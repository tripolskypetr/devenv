@echo off
call docker build --platform linux/amd64 -t tripolskypetr/devenv . -f Dockerfile
if errorlevel 1 (
    echo Build failed, publish cancelled.
    exit /b 1
)
call docker push tripolskypetr/devenv:latest
