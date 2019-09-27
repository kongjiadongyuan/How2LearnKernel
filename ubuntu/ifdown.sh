#!/bin/sh

echo ""
echo ""
echo "----------------[!] kjdy-QUMU Netdev Tap Down Script----------------"
echo "[-] Turning down $1."
brctl delif br0 $1
ip link set dev $1 down 
ip link delete $1
echo "[.] Done."

echo "[-] Deleting br0 and unlinking enp24s0."
brctl delif br0 enp24s0 
ip link set dev br0 down 
brctl delbr br0 
echo "[.] Done."

echo "[-] Restoring iptables."
iptables -D FORWARD -p all -i br0 -j ACCEPT
echo "[.] Done."

echo "[+] Re-Alloc ip to enp24s0."
ip addr flush dev enp24s0 
dhclient -q -v enp24s0
echo "[.] Done."
echo "----------------[.] kjdy-QUMU Netdev Tap Down Script----------------"
echo ""
echo ""
