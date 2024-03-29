#!/bin/bash

# Args: [PI_ADDR]

PI_USER=pi
PI_ADDR="10.27.6.61"
PI_DIR='/home/pi/Streamer'
LOCAL_ZIP_PATH="output/Streamer.zip"

# If user provided an IP address on the command line, use that
if [[ $1 != "" ]]; then
  PI_ADDR=$1
fi

echo "Make sure you've done a \"git pull\" so that you're deploying the latest code!"
echo

./gradlew build -PbuildType=arm-raspbian -PtestType=linux-x86_64

# ERROR HANDLING: check that the build succeeded
if [ $? -ne 0 ]; then
  # gradle will have output lots of error messages, so we don't need to.
  exit 1
fi

# Make sure the target folder exists and copy the newly built zip to the pi
echo "Copying newly built jar to $PI_USER@$PI_ADDR"
ssh ${PI_USER}@${PI_ADDR} "mkdir -p ${PI_DIR}"
scp ${LOCAL_ZIP_PATH} ${PI_USER}@${PI_ADDR}:${PI_DIR}
ssh ${PI_USER}@${PI_ADDR} "yes | unzip ${PI_DIR}/$(basename ${LOCAL_ZIP_PATH}) -d ${PI_DIR}"

# ERROR HANDLING: if the copy failed, abort
if [ $? -ne ]; then
  # output to stderr
  >&2 echo "Error: Copy failed! Aborting."
  exit 1
fi

# Restart the vision process on the pi
source pi_scripts/restartStreamerProcessOnPi.sh ${PI_ADDR}
