# Prometheus Reloader

[![Build Status](https://api.cirrus-ci.com/github/cirruslabs/actions-trigger.svg)](https://cirrus-ci.com/github/cirruslabs/actions-trigger) [![](https://images.microbadger.com/badges/version/cirrusci/actions-trigger.svg)](https://microbadger.com/images/cirrusci/actions-trigger) [![](https://images.microbadger.com/badges/image/cirrusci/actions-trigger.svg)](https://microbadger.com/images/cirrusci/actions-trigger)

The container in this repository will watch up to 2 files for changes, and if those files change it will hit an API endpoint. This is extremely useful when you need to reload Prometheus when the rules or configuration files changes.

Based on: https://github.com/tolleiv/docker-misc/tree/master/2017-prometheus-reload

## Requirements

* Linux / MacOSX, [`git bash`](https://git-scm.com/download/win) for Windows
* [docker](https://www.docker.com)

## Building the container
```
git clone https://github.com/billykwooten/prometheus_reloader.git
cd prometheus_reloader
bash scripts/cibuild.sh
```

Once the container builds, it will be tagged with the latest git commit.


## Running the container

You will need to mount in the directory that contains the files you want to watch.

```
# docker run --name prometheus_reloader -d --restart always -v $(pwd):/mnt prometheus_reloader:<IMAGE TAG> <URL WEBHOOK> <FILE1> <FILE2>
```

Running Example:
```
# ls
testfile1 testfile2
# docker run --name prometheus_reloader -d --restart always -v $(pwd):/mnt prometheus_reloader:dcd7135ef http://server.local:9090/-/reload /mnt/testfile1 /mnt/testfile2
# docker logs prometheus_reloader
>>>>>>>>>>>>>>>>>>>>>>>
[1545286342] Starting Prometheus Reloader
[1545286342] Loaded files:
[1545286342]    - /mnt/testfile1
[1545286342]    - /mnt/testfile2
[1545286342] Waiting for file changes...

[1545286362] Trigger refresh due to /mnt/testfile1 change
[1545286372] Trigger refresh due to /mnt/testfile2 change
```
