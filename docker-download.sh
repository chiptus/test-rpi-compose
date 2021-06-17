#!/usr/bin/env bash

PLATFORM=$1
ARCH=$2
DOCKER_VERSION=$3
DOCKER_COMPOSE_PLUGIN_VERSION="v2.0.0-beta.3"

DOWNLOAD_FOLDER=".tmp/download"

rm -rf "${DOWNLOAD_FOLDER}"
mkdir -pv "${DOWNLOAD_FOLDER}"

if [ "${PLATFORM}" == 'win' ]; then
    wget -O "${DOWNLOAD_FOLDER}/docker-binaries.zip" "https://dockermsft.azureedge.net/dockercontainer/docker-${DOCKER_VERSION}.zip"
    unzip "${DOWNLOAD_FOLDER}/docker-binaries.zip" -d "${DOWNLOAD_FOLDER}"
    mv "${DOWNLOAD_FOLDER}/docker/docker.exe" dist/
    mv ${DOWNLOAD_FOLDER}/docker/*.dll dist/
else
    wget -O "${DOWNLOAD_FOLDER}/docker-binaries.tgz" "https://download.docker.com/${PLATFORM}/static/stable/${ARCH}/docker-${DOCKER_VERSION}.tgz"
    tar -xf "${DOWNLOAD_FOLDER}/docker-binaries.tgz" -C "${DOWNLOAD_FOLDER}"
    mv "${DOWNLOAD_FOLDER}/docker/docker" dist/
    
    if [[ "$ARCH" == "aarch64" ]]; then
        ARCH="arm64"
    fi
    
    wget -O "${DOWNLOAD_FOLDER}/docker-compose" "https://github.com/docker/compose-cli/releases/download/$DOCKER_COMPOSE_PLUGIN_VERSION/docker-compose-${PLATFORM}-${ARCH}"
    chmod +x "${DOWNLOAD_FOLDER}/docker-compose"
    mkdir -p "dist/.docker/cli-plugins/"
    mv "${DOWNLOAD_FOLDER}/docker-compose" "dist/.docker/cli-plugins/"
fi

rm -rf "${DOWNLOAD_FOLDER}"
