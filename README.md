# Nextcloud Images

[![Image Build](https://github.com/hathagat/nextcloud/actions/workflows/build.yml/badge.svg)](https://github.com/hathagat/nextcloud/actions/workflows/build.yml)

Images in this repository are based on [this Dockerfile](https://github.com/nextcloud/docker/tree/master/.examples/dockerfiles/full/fpm).  
Additionally they contain a Nginx web proxy running on port 9000 so you don't need a seperate Container for serving static files like described in the [upstream documentation](https://github.com/nextcloud/docker#base-version---fpm). All other parts of this docs are still valid.

## Available images

```
ghcr.io/hathagat/nextcloud:latest
ghcr.io/hathagat/nextcloud:26
```
