FROM timhaak/base
MAINTAINER Tim Haak <tim@haak.co>

COPY settings.json /var/lib/transmission-daemon/info/settings.json

RUN add-apt-repository -y ppa:transmissionbt/ppa && \
    apt-get -q update && \
    apt-get install -qy --force-yes transmission-daemon ca-certificates wget tar curl unrar-free procps && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/torrents"]

ADD ./settings.json /var/lib/transmission-daemon/info/settings.json

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

#9091
EXPOSE 80 45555

CMD ["/start.sh"]
