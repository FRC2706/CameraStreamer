#!/bin/bash

# Args: [PI_ADDR]

PI_USER=pi
PI_ADDR="10.27.6.61"

# If user provided an IP address on the command line, use that
if [[ $1 != "" ]]; then
  PI_ADDR=$1
fi


# TODO Explain-y comments

scp ${PI_USER}@${PI_ADDR} pi_scripts/streamer.service ${PI_USER}@${PI_ADDR}:/tmp
ssh ${PI_USER}@${PI_ADDR} "sudo cp /tmp/streamer.service /etc/systemd/system && sudo systemctl stop streamer.service && sudo systemctl disable streamer.service && sudo systemctl daemon-reload && sudo systemctl enable 
streamer.service && sudo systemctl start streamer.service"

