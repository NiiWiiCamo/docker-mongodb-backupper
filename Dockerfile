FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy
LABEL org.opencontainers.image.authors="docker@nilsblume.de"

RUN apt update
RUN apt install -y cron git wget

ARG MONGOTOOLS_URL="https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.6.1.deb"

RUN wget ${MONGOTOOLS_URL}
RUN apt install ./mongodb-database-tools-*.deb && rm ./mongodb-database-tools-*.deb

ADD cronfile /backupper/cronfile
ADD clouddb-backup.sh /backupper/clouddb-backup.sh

RUN crontab -u abc /backupper/cronfile

ENV MONGODB_DATABASE="database"
ENV MONGODB_USER="admin"
ENV MONGODB_PASSWORD="admin"
ENV MONGODB_URI="mongodb://localhost"

VOLUME /data