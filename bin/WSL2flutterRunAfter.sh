#!/bin/bash

WINDOWS_IP=$(cat /etc/resolv.conf | grep nameserver | tail -1 | cut -d' ' -f2)

VMSERVICE_PORT=20001
VMSERVICE_SOCAT_PID=$(ps aux | grep -i socat | grep ${VMSERVICE_PORT} | awk '{ print $2; }')
if [ "${VMSERVICE_SOCAT_PID}" != "" ]; then
  kill ${VMSERVICE_SOCAT_PID}
fi
socat tcp-listen:${VMSERVICE_PORT},reuseaddr,bind=127.0.0.1,fork tcp:${WINDOWS_IP}:${VMSERVICE_PORT} &
