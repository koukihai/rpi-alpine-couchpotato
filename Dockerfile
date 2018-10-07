FROM multiarch/alpine:armhf-latest-stable

# Install packages
RUN apk add --update \
    git \
    openssl \
    python \
    py-lxml \
    py-openssl

# Cleanup
RUN rm -rf /var/cache/apk/*

# Create user
RUN id couchpotato || adduser -S -s /bin/false -H -D couchpotato
RUN addgroup couchpotato users

# Create directories
RUN mkdir -p /config /blackhole /sorted /unsorted /app && \
    chmod 775 /config /blackhole /sorted /unsorted && \
    chgrp -R users /sorted /unsorted /blackhole && \
    chown -R couchpotato:users /config /app

# Continue as user 'couchpotato'
USER couchpotato

RUN git clone --depth 1 -b master --single-branch https://github.com/CouchPotato/CouchPotatoServer.git /app

VOLUME /config /blackhole /sorted /unsorted

EXPOSE 5050

CMD ["/usr/bin/env","python2","/app/CouchPotato.py", "--data_dir=/config", "--config_file=/config/CouchPotato.cfg", "--console_log" ]
