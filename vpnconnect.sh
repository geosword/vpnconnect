#!/bin/bash
# parameter 1 is the name of the vpn connection in Network Manager
if [ $# -eq 0 ]
  then
    echo "You must specify a connection name to start / stop"
    exit 1
fi

NMCLI=$(which nmcli)
if [ -z "$NMCLI" ]; then
	echo "I need network manager installed to run"
	exit 1
fi

# first check to see if we're already connected to ${1}
if $NMCLI connection show --active | grep -Eq "^${1}\s"; then
	# we're already connected, so disconnect
	$NMCLI connection down id ${1}
 else
 	# we're not connected, so connect
 	$NMCLI connection up id ${1}
fi