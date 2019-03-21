#!/bin/bash

# Args: [PI_ADDR]

PI_USER=pi
PI_ADDR="10.27.6.61"

# If user provided an IP address on the command line, use that
if [[ $1 != "" ]]; then
  PI_ADDR=$1
fi

ssh ${PI_USER}@${PI_ADDR} "sudo systemctl stop streamer.service && sudo systemctl disable streamer.service && sudo rm /etc/systemd/system/streamer.service && sudo systemctl daemon-reload"
