FROM library/debian:12-slim

ARG version=4.1.7

COPY --chown=root:root config docker-entrypoint.sh /

RUN apt-get update \
 && apt-get install --assume-yes --no-install-recommends \
      ca-certificates \
      curl \
      nginx-full \
      php-fpm \
      php-mbstring \
      rtorrent \
      s6 \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd --gid 10000 rutorrent \
 && useradd \
      --home-dir /data \
      --gid 10000 \
      --groups tty \
      --no-create-home \
      --no-user-group \
      --shell /usr/sbin/nologin \
      --uid 10000 \
      data
 && install \
      --directory \
      --group rutorrent \
      --mode 0700 \
      --owner rutorrent \
      /home/rutorrent \
 && install \
      --directory \
      --group root \
      --mode 0755 \
      --owner root \
      /var/www/rutorrent \
 && curl -sSL "https://github.com/Novik/ruTorrent/archive/refs/tags/v${version}.tar.gz" \
      | tar --extract \
          --ungzip \
          --directory /var/www/rutorrent \
          --no-same-owner \
          --no-same-permissions \
          --strip-components 1 \
 && sed --in-place \
      --expression '/$scgi_port =/c\$scgi_port = 0;' \
      --expression '/$scgi_host =/c\$scgi_host = "unix:///run/rutorrent/scgi.sock";' \
      --expression '/$profilePath =/c\$profilePath = "/data";' \
      --expression '/$profileMask =/c\$profileMask = 0700;' \
      /var/www/rutorrent/conf/config.php \
 && chmod 0755 /config/s6/*/run /docker-entrypoint.sh

WORKDIR /data
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/usr/bin/s6-svscan", "/run/s6"  ]
