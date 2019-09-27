#!/bin/sh

thispath=$(dirname $(realpath $0))

qemu-system-x86_64 \
  -hda ${thispath}/ubuntuserver.img \
  -boot d \
  -cdrom ${1} \
  -m 4096 \
  -netdev tap,id=virtnet0,script=${thispath}/ifstart.sh,downscript=${thispath}/ifdown.sh \
  -device e1000,netdev=virtnet0,mac=fa:06:8a:4a:18:06 \
  -enable-kvm \
  -smp 4,cores=2,threads=2,sockets=1 
