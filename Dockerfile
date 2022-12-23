FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy
LABEL org.opencontainers.image.authors="docker@nilsblume.de"

RUN apt-get update
RUN apt-get install -y cron git wget

ARG MONGOTOOLS_URL="https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.6.1.deb"

RUN wget ${MONGOTOOLS_URL}
RUN apt-get install ./mongodb-database-tools-*.deb &&\
    rm ./mongodb-database-tools-*.deb

ADD *cron /backupper/
ADD *.sh /backupper/
ADD ./etc/services.d /etc/services.d

RUN usermod -d /home/abc -s /bin/bash -m abc

RUN crontab -u abc /backupper/usercron &&\
    rm /backupper/usercron

ENV MONGODB_DATABASE="database"
ENV MONGODB_USER="admin"
ENV MONGODB_PASSWORD="admin"
ENV MONGODB_URI="mongodb://localhost"

VOLUME /data
VOLUME /config
