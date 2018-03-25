FROM node:latest

LABEL Aleksandar Krsteski "krsteski_aleksandar@hotmail.com"

ENV LANG=C.UTF-8

# heroku installtion script do "apt-get update -qq"
# there is no need to repeat it
RUN wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh && \
	# upgrade and install additional packages
	apt-get upgrade -yqq && \
    apt-get install sudo tmux -yqq && \
    apt-get --purge autoremove -y && \
    apt-get autoclean && \
	# install globally node packages
	npm i -g nodemon node-gyp

ARG USER=acika

RUN usermod -l $USER node && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

USER $USER

# set git aliases
RUN git config --global alias.s status && \
    git config --global alias.c checkout && \
    git config --global alias.b branch

WORKDIR /home/$USER/workspace

# Exec form for ENTRYPOINT
# ENTRYPOINT ["tmux", "new", "-s", "nodejs"]

# Shell form of ENTRYPOINT ignores any CMD
#  or docker run command line arguments
ENTRYPOINT tmux new -s nodejs