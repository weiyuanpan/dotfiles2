#!/bin/sh

vpn_name="PicoCELA Tokyo"
iface=ppp0

echo "> Start VPN $vpn_name"
networksetup -connectpppoeservice "$vpn_name"

sleep 5s

echo "> Add routes for IPv4 inbound for bitbucket.org, api.bitbucket.org, and altssh.bitbucket.org"
sudo route add 104.192.136.0/21 -interface $iface
sudo route add 185.166.140.0/22 -interface $iface
sudo route add 13.200.41.128/25 -interface $iface

echo "> Add routes for PicoManager Manager sites"
dig +short manager.picomanager.net | \
grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | \
xargs -r -I{} sudo route add "{}" -interface $iface
dig +short manager-dev.picomanager.net | \
grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | \
xargs -r -I{} sudo route add "{}" -interface $iface

echo "> Add routes for PicoManager Servers"
sudo route add 13.112.228.30 -interface $iface
sudo route add 54.95.123.169 -interface $iface
sudo route add 3.112.203.41 -interface $iface

echo "> Add routes for PicoManager Portal DB"
dig +short portaldb.c6wlblq4eqnx.ap-northeast-1.rds.amazonaws.com | \
grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | \
xargs -r -I{} sudo route add "{}" -interface $iface
