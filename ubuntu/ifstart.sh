#!/bin/sh

echo ""
echo ""
echo "----------------[!] kjdy-QUMU Netdev Tap Startup Script----------------"
echo "[+] Generating br0 and linking enp24s0."
brctl addbr br0
ip addr flush dev enp24s0
brctl addif br0 enp24s0
ifconfig enp24s0 up
ifconfig br0 up
echo "[.] Done."

echo "[+] Distributing ip to br0."
dhclient -q -v br0 
echo "Done."

echo "[+] Editing iptables.(docker may drop the forward packets)"
iptables -A FORWARD -p all -i br0 -j ACCEPT
echo "[.] Done."

echo "[+] Activating $1 and link it to bridge."
brctl addif br0 $1 
ip link set dev $1 up
echo "[.] Done."
echo "----------------[.] kjdy-QUMU Netdev Tap Startup Script----------------"
echo ""
echo ""
