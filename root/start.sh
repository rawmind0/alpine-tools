#!/usr/bin/env sh

SERVICE_UID=${SERVICE_UID:-"0"} 
SERVICE_GID=${SERVICE_GID:-"0"}
SERVICE_VOLUME=${SERVICE_VOLUME:-"/opt/tools"}

# Untar tools.tgz into /opt/tools
tar xzvf /opt/tools.tgz -C ${SERVICE_VOLUME}
chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${SERVICE_VOLUME}

true