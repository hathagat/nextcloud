FROM nextcloud:32-fpm

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        ghostscript \
        procps \
        smbclient \
        supervisor \
        nginx \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libbz2-dev \
        libkrb5-dev \
        libsmbclient-dev \
    ; \
    \
    docker-php-ext-install \
        bz2 \
    ; \
    pecl install smbclient; \
    docker-php-ext-enable smbclient; \
    \
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
        | awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); print so }' \
        | sort -u \
        | xargs -r dpkg-query --search \
        | cut -d: -f1 \
        | sort -u \
        | xargs -rt apt-mark manual; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p \
    /var/log/supervisord \
    /var/run/supervisord \
; chown 33:33 /var/www/data \
;

COPY supervisord.conf /
COPY --chown=33:33 nginx.conf /etc/nginx/
COPY php-fpm.conf /usr/local/etc/php-fpm.d/zzz-nextcloud.conf

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
