#!/usr/bin/env sh

SERVICE_UID=${SERVICE_UID:-"0"} 
SERVICE_GID=${SERVICE_GID:-"0"}
SERVICE_VOLUME=${SERVICE_VOLUME:-"/opt/tools"}
KEEP_ALIVE=${KEEP_ALIVE:-"0"}

# Untar tools packages into /opt/tools
for i in `ls -r1 /opt/*.tgz`; do 
	tar xzvf $i -C ${SERVICE_VOLUME}
done
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