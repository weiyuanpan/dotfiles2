#!/bin/sh

set -eu

PEM_FILE=$1
NODE=$2
UI_PORT=${3-8080}
WEBSOCKET_PORT=${4-9001}

BASTION_SERVER=13.112.228.30 

ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -L 127.0.0.1:$UI_PORT:unit$NODE.innervpn.picomanager.net:80 -N $BASTION_SERVER -l ubuntu -i "$PEM_FILE" &
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -L 127.0.0.1:$WEBSOCKET_PORT:unit$NODE.innervpn.picomanager.net:9001 -N $BASTION_SERVER -l ubuntu -i "$PEM_FILE" &
echo connecting ...

# solve the problem that $(jobs -p) return nothing under ubuntu
jobs -p > /tmp/remote_webui_ps
PS=$(cat /tmp/remote_webui_ps | xargs)

trap "echo disconnected; kill $PS" 2 # SIGINT
wait
