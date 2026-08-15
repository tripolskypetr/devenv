#!/bin/bash
docker build --platform linux/amd64 -t tripolskypetr/devenv . -f Dockerfile
docker push tripolskypetr/devenv:latest
