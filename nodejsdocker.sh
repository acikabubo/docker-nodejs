#!/bin/bash
nodejsdocker() {
    CONTAINER_NAME="nodejs"

    if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
        # docker exec -it ${CONTAINER_NAME} tmux new -s nodejs
        docker exec -it ${CONTAINER_NAME} bash

        docker-compose down
    else
        docker run --rm -it -v /home/$USER/development/workspace/nodejs:/home/$USER/workspace -v ~/.ssh:/home/$USER/.ssh -p 3000:3000 --hostname nodejsdocker --name nodejs acikabubo/nodejs
    fi
}

nodejsdocker
