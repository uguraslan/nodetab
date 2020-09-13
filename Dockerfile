FROM node:buster-slim

RUN apt-get update && \ 
apt-get install --no-install-recommends -y cron logrotate && \
apt-get --purge -y autoremove && \
apt-get -qq clean && \
rm -rf /usr/share/doc /usr/share/man /var/lib/apt/lists/* /root/* /tmp/* 

COPY ./logrotate.conf /etc/logrotate.d/nodetab
COPY ./cron.sh /cron.sh

CMD ["/bin/bash", "/cron.sh"]