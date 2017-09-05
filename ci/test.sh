#!/usr/bin/env bash

parent_path=$( cd "$(dirname ${BASH_SOURCE[0]})" ; pwd -P )
source $parent_path/common.sh

if [ -n "$1" ]; then
	sourceFile "$1"
fi

log "Finding ${DOCKER_IMAGE}..."
list_image=$(docker images -q ${DOCKER_IMAGE})
checkError $?

exist_image=$(echo $list_image | wc -l)
if [ "$exist_image" -ne "1" ]; then
	log "Loading ${DOCKER_IMAGE} ..."
	docker load -i ${DOCKER_ARCHIVE}
	checkError $?
fi

log "Running ${DOCKER_IMAGE} ..."
CHECK=$(docker run -t --rm ${DOCKER_IMAGE} cat /etc/alpine-release )
checkError $?

log "Testing ${DOCKER_IMAGE} ..."
CHECK_VER=$(echo ${CHECK} | cut -d. -f1,2 )
EXPECTED_VER=$(echo ${TAG} | cut -d"-" -f1)

if [ "$CHECK_VER" != "$EXPECTED_VER" ]; then 
	log "ERROR got $CHECK_VER expected $EXPECTED_VER"
	exit 1
fi

log "OK"
exit 0
