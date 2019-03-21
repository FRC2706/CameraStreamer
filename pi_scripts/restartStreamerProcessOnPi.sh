#!/bin/bash

# Args: [PI_ADDR]

# Assuming the streamer process is already installed and running on the target pi,
# restart it using systemd

PI_USER=pi
PI_ADDR="10.27.6.61"

# If user provided an IP address on the command line, use that
if [[ $1 != "" ]]; then
  PI_ADDR=$1
fi


# SSH to the pi and restart the streamer process
echo "Restarting streamer process on ${PI_USER}@${PI_ADDR}"
ssh ${PI_USER}@${PI_ADDR} "sudo systemctl stop streamer.service && sudo systemctl daemon-reload && sudo systemctl start streamer.service"
