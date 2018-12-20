#!/usr/bin/env bash
#
# Build Prometheus Reloader 
#

echo;echo ">>>> Running ShellCheck against the script";echo
docker pull koalaman/shellcheck:stable
docker run --rm -v "$(pwd)/refresh.sh:/mnt/refresh.sh" koalaman/shellcheck /mnt/refresh.sh || exit 1 

echo;echo ">>>> Building Docker Container"; echo
docker build -t prometheus_reloader:$(git rev-parse HEAD | cut -c1-9) .

