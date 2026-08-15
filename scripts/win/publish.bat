@echo off
call docker build --platform linux/amd64 -t tripolskypetr/devenv . -f Dockerfile
call docker push tripolskypetr/devenv:latest
