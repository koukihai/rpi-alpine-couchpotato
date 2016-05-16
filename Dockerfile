FROM hypriot/rpi-alpine-scratch


# Install packages
RUN apk add --update \
    git \
    python 

# Download and install lxml
RUN wget http://nl.alpinelinux.org/alpine/v3.3/main/armhf/py-lxml-3.5.0-r0.apk -O /var/cache/apk/py-lxml.apk
RUN apk add --allow-untrusted /var/cache/apk/py-lxml.apk

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

# Continue as user 'headphones'
USER couchpotato

RUN git clone --depth 1 -b master --single-branch https://github.com/RuudBurger/CouchPotatoServer.git /app 

VOLUME /config /blackhole /sorted /unsorted

EXPOSE 5050

CMD [ "--data_dir=/config", "--config_file=/config/CouchPotato.cfg", "--console_log" ]
ENTRYPOINT ["/usr/bin/env","python2","/app/CouchPotato.py"]
