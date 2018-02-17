FROM node:latest

LABEL Aleksandar Krsteski "krsteski_aleksandar@hotmail.com"

ENV LANG=C.UTF-8

RUN apt-get update -qq && \
    apt-get upgrade -yqq && \
    apt-get install sudo tmux -yqq && \
    apt-get autoremove -y && \
    apt-get autoclean

RUN npm install nodemon -g

ARG USER=acika
ARG uid=1001
ARG gid=1001

RUN groupadd -g $gid $USER && \
    useradd -ms /bin/bash -u $uid -g $gid $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

# RUN chown -R $USER:$USER /usr/local/lib/node_modules
RUN mkdir /workspace && \
    chown -R $USER:$USER /workspace

USER $USER

WORKDIR /workspace

ENTRYPOINT tmux
