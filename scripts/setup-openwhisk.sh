#!/bin/bash

DOCKER_COMPOSE="docker-compose"
DOCKER_COMPOSE_TMP="$DOCKER_COMPOSE.bin"

version_exists=$( (docker-compose --version | grep "${DOCKER_COMPOSE_VERSION}") || echo "false" )

# This script assumes Docker is already installed
# Trusty for Travis SHOULD include latest docker compose (e.g., 1.13.0)
if [ "${version_exists}" == "false" ]
then
    echo "Installing Docker Compose ${DOCKER_COMPOSE_VERSION}"
    if [ -f /usr/local/bin/$DOCKER_COMPOSE ]; then
        sudo rm /usr/local/bin/$DOCKER_COMPOSE
    fi
    curl -L https://github.com/docker/compose/releases/download/"${DOCKER_COMPOSE_VERSION}"/docker-compose-"$(uname -s)"-"$(uname -m)" > $DOCKER_COMPOSE_TMP
    chmod +x $DOCKER_COMPOSE_TMP
    sudo mv $DOCKER_COMPOSE_TMP /usr/local/bin/$DOCKER_COMPOSE
fi
echo "Docker Compose Version:" "$(docker-compose --version)"

git clone https://github.com/apache/incubator-openwhisk-devtools
pushd incubator-openwhisk-devtools/docker-compose
make quick-start
WSK_CONFIG_FILE=$(pwd)/.wskprops
export WSK_CONFIG_FILE
sudo mv ./openwhisk-src/bin/wsk /usr/local/bin/wsk
popd
alias wsk='wsk -i'
alias wsk
which wsk
wsk list
