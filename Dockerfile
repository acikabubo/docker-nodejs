FROM node:latest

LABEL Aleksandar Krsteski "krsteski_aleksandar@hotmail.com"

ENV LANG=C.UTF-8

# heroku installtion script do "apt-get update -qq"
# there is no need to repeat it
RUN wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# upgrade and install additional packages
RUN apt-get upgrade -yqq && \
    apt-get install sudo tmux -yqq && \
    apt-get autoremove -y && \
    apt-get autoclean

RUN npm i -g nodemon node-gyp

ARG USER=acika

RUN usermod -l $USER node
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

USER $USER

# set git aliases
RUN git config --global alias.s status && \
    git config --global alias.c checkout && \
    git config --global alias.b branch

WORKDIR /home/$USER/workspace

ENTRYPOINT ["tmux", "new", "-s", "nodejs"]
