# Prometheus Reloader

The container in this repository will watch up to 2 files for changes, and if those files change it will hit an API endpoint. This is extremely useful when you need to reload Prometheus when the rules or configuration files changes.

## Requirements

* Linux / MacOSX, [`git bash`](https://git-scm.com/download/win) for Windows
* [docker](https://www.docker.com)

## Building the container

```
git clone https://github.com/billykwooten/prometheus_reloader.git
cd prometheus_reloader
bash scripts/cibuild.sh
```

## Running the container

You will need to mount in the directory that contains the files you want to watch.

```
# docker run --name prometheus_reloader -d --restart always -v $(pwd):/mnt prometheus_reloader <URL WEBHOOK> <FILE1> <FILE2>
```

Running Example:
```
# ls
testfile1 testfile2
# docker run --name prometheus_reloader -d --restart always -v $(pwd):/mnt prometheus_reloader http://server.local:9090/-/reload /mnt/testfile1 /mnt/testfile2
```
