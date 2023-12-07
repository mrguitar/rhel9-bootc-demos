#!/bin/bash
#
sudo virsh destroy bootc
sudo virsh undefine bootc --remove-all-storage --keep-nvram

sudo qemu-img create -f qcow2 /var/home/bbreard/data/images/bootc.qcow2 20G
sudo virt-install \
  --name bootc \
  --memory 4096 \
  --vcpus 4 \
  --disk=path=/var/home/bbreard/data/images/bootc.qcow2 \
  --location https://dl.fedoraproject.org/pub/fedora/linux/releases/38/Everything/x86_64/os/ \
  --os-variant rhel9.0 \
  --boot loader=/usr/share/edk2/ovmf/OVMF_CODE.fd,loader.readonly=yes,loader.secure=no,loader.type=pflash,nvram=/var/lib/libvirt/qemu/nvram/bootc.fd \
  --initrd-inject /var/home/bbreard/src/rhel9-bootc/example.ks \
  --extra-args="inst.profile=rhel inst.ks=file:/example.ks" 
  #--extra-args="inst.profile=rhel inst.ks=file:/example.ks console=tty0 console=ttyS0,115200n8" 
#  --boot uefi,loader.secure=false \

#exec virt-install --connect qemu:///system --name sagano-demo --memory 2048 --vcpus 4 --disk size=40 \
#          --os-variant rhel9.0 --location https://dl.fedoraproject.org/pub/fedora/linux/releases/38/Everything/x86_64/os/ \
#          --noautoconsole --initrd-inject $(pwd)/basic.ks --extra-args="inst.ks=file:/basic.ks console=ttyS0"

#sudo virt-install \
#  --name=bootc \
#  --ram=4096 \
#  --vcpus=2 \
#  --os-variant=rhel9.2 \
#  --graphics=vnc \
#  --pxe \
#  --disk=path=/var/home/bbreard/data/images/node0.qcow2 \
#  --check path_in_use=off \
#  --network=network=default,model=virtio,mac=52:54:00:9e:5d:d4 \
#  --boot loader=/usr/share/OVMF/OVMF_CODE.secboot.fd,loader.readonly=yes,loader.type=pflash,nvram.template=/usr/share/OVMF/OVMF_VARS.secboot.fd,loader_secure=yes \
#  --features smm.state=on
