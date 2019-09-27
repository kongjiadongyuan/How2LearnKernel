#!/bin/sh

#  qemu-system-x86_64 \
#   -boot c \
#   -hda ubuntuserver.img \
#   -m 4096 \
#   -netdev tap,id=virtnet0,script=./ifstart.sh,downscript=./ifdown.sh \
#   -device e1000,netdev=virtnet0,mac=fa:06:8a:4a:18:06 \
#   -enable-kvm \
#   -serial tcp::1234,server,nowait \
#   -smp 4,cores=2,threads=2,sockets=1 \
#   -fsdev local,id=common,path=/home/kongjiadongyuan/common,security_model=passthrough \
#   -device virtio-9p-pci,id=fs0,fsdev=common,mount_tag=hostshare

thispath=$(dirname $(realpath $0))
exec qemu-system-x86_64 \
  -boot c \
  -hda ${thispath}/ubuntuserver.img \
  -m 4096 \
  -netdev tap,id=virtnet0,script=${thispath}/ifstart.sh,downscript=${thispath}/ifdown.sh \
  -device e1000,netdev=virtnet0,mac=fa:06:8a:4a:18:06 \
  -enable-kvm \
  -smp 4,cores=2,threads=2,sockets=1 \
  -s
