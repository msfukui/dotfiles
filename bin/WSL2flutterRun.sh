#!/bin/bash

VMSERVICE_PORT=20001
DDS_PORT=20003

VMSERVICE_SOCAT_PID=$(ps aux | grep -i socat | grep ${VMSERVICE_PORT} | awk '{ print $2; }')
if [ "${VMSERVICE_SOCAT_PID}" != "" ]; then
  kill ${VMSERVICE_SOCAT_PID}
fi

flutter run -v -d emulator-5554 --host-vmservice-port=${VMSERVICE_PORT} --dds-port=${DDS_PORT}
