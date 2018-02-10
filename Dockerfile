FROM node:latest

LABEL Aleksandar Krsteski "krsteski_aleksandar@hotmail.com"

ENV LANG=C.UTF-8

RUN apt-get update -qq  && \
    apt-get upgrade -yqq && \
    apt-get install tmux -yqq && \
    apt-get autoremove -y && \
    apt-get autoclean


ARG user=acika
ARG uid=1001
ARG gid=1001

RUN groupadd -g $gid $user; exit 0  # do not crash on already existing GID
RUN useradd -ms /bin/bash -u $uid -g $gid $user

USER $user

WORKDIR /workspace

CMD ['tmux']
