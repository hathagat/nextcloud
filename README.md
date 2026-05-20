# Nextcloud Images

[![Image Build](https://github.com/hathagat/nextcloud/actions/workflows/build.yml/badge.svg)](https://github.com/hathagat/nextcloud/actions/workflows/build.yml)

Custom Nextcloud container images based on the [upstream FPM Dockerfile](https://github.com/nextcloud/docker/tree/master/.examples/dockerfiles/full/fpm), extended with a built-in Nginx so a separate web server container is not required. Apart from that, the [upstream documentation](https://github.com/nextcloud/docker#base-version---fpm) still applies.

## Features

- Based on the official `nextcloud:<version>-fpm` image
- Nginx reverse proxy bundled in the same container, listening on port `9000`
- PHP-FPM talks to Nginx via a Unix socket (`/run/php-fpm.sock`)
- Supervisord supervises `php-fpm`, `nginx` and `cron`
- Recommended OPcache settings including JIT enabled
- Extra runtime tools: `ffmpeg`, `ghostscript`, `smbclient`

## Available images

```
ghcr.io/hathagat/nextcloud:latest
ghcr.io/hathagat/nextcloud:32
ghcr.io/hathagat/nextcloud:31
ghcr.io/hathagat/nextcloud:30
```

Only `latest` and the current major are rebuilt on schedule. Older tags remain available as the last build of that major version and do not receive further updates.

Images are signed with [cosign](https://github.com/sigstore/cosign) (keyless, GitHub OIDC).

## Usage

The image is a drop-in replacement for `nextcloud:fpm` but exposes HTTP on port `9000` instead of FPM. All environment variables and volume conventions from the [upstream image](https://github.com/nextcloud/docker#environment-variables) are supported.
