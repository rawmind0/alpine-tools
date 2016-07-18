#!/usr/bin/env sh

SERVICE_UID=${SERVICE_UID:-"0"} 
SERVICE_GID=${SERVICE_GID:-"0"}
SERVICE_VOLUME=${SERVICE_VOLUME:-"/opt/tools"}
SERVICE_ARCHIVE=${SERVICE_ARCHIVE:-"/opt/tools.tgz"}
KEEP_ALIVE=${KEEP_ALIVE:-"0"}

# Untar tools.tgz into /opt/tools
tar xzvf /opt/tools.tgz -C ${SERVICE_VOLUME}
chown -R ${SERVICE_UID}:${SERVICE_GID} ${SERVICE_VOLUME}

if [ "x$KEEP_ALIVE" == "x1" ]; then
	trap "exit 0" SIGINT SIGTERM
	while :
	do
		echo `date` $ME - "I'm alive"
		sleep 600
	done
fi
exit 0