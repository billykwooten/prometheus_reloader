#!/usr/bin/env bash
#
# Build Prometheus Reloader 
#

echo ">>>> Running ShellCheck against the script"; echo
docker pull koalaman/shellcheck:stable
docker run --rm -v "$PWD/..:/mnt" koalaman/shellcheck /mnt/refresh.sh || exit 1 

echo ">>>> Building Docker Container"; echo
docker build -t prometheus_reloader ..

