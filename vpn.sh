#!/usr/bin/nv bash

case $1 in 
    c|connect|co)
	echo "Connect to vpn..."
	sudo vpnc
	VPN_IP=`ifconfig tun0 | grep inet | cut -d ' ' -f 2`
	echo "Add route to $VPN_IP"
	echo `sudo route add -net 10.0.0.0 netmask 255.0.0.0 dev tun0`
	echo "Delete default route..."
	echo `sudo route delete default`
	echo "Set new default route..."
	echo `sudo route add default gw 192.168.0.254`
# 255.255.255.0` 
	echo "VPN UP"
	;;
    d|disconnect)
	echo "Disconnect to webedia vpn..."
	sudo vpnc-disconnect
	echo "VPN DOWN"
	;;
    *)
	echo "Usage $0 c|connect|co|d|disconnect"
	;;
esac
