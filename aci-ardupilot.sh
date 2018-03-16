#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
    echo "This script uses functionality which requires root privileges"
    exit 1
fi

acbuild --debug begin docker://ubuntu:xenial

# In the event of the script exiting, end the build
trap "{ export EXT=$?; acbuild --debug end && exit $EXT; }" EXIT


# Install dependencies
acbuild --debug run -- apt-get update
acbuild --debug run -- apt-get install -y python-matplotlib python-serial python-wxgtk3.0 python-wxtools python-lxml
acbuild --debug run -- apt-get install -y python-scipy python-opencv ccache python-pip python-pexpect
acbuild --debug run -- apt-get install -y python-setuptools gcc gawk make git curl g++ python-serial python-numpy python-pyparsing realpath
acbuild --debug run -- apt-get install -y libxml2-dev libxslt-dev python-dev python-pygame
acbuild --debug run -- pip2 install wheel setuptools catkin_pkg future dronekit lxml --upgrade
acbuild --debug run -- pip2 install -U pymavlink MAVProxy




# Choose the user to run-as inside the container
acbuild --debug run -- adduser --system --home /home/gopher --shell /bin/sh --group --disabled-password gopher
acbuild --debug run -- usermod -a -G www-data gopher
acbuild --debug set-user gopher



# Make the container's entrypoint the shell for now
#acbuild --debug set-exec -- /usr/sbin/nginx -g 'master_process off;'
acbuild --debug set-exec -- /bin/sh


# Write the result
acbuild --debug set-name shrmpy/ardupilot
acbuild --debug label add version 0.0.1
acbuild --debug annotation add authors "杜興怡"
acbuild --debug write --overwrite ardupilot-0.0.1-linux-amd64.aci
