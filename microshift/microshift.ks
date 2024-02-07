text

# Basic partitioning
zerombr
clearpart --all --initlabel --disklabel=gpt
part /boot/efi --size=100  --fstype=efi
part /boot     --size=1000  --fstype=ext4 --label=boot
part pv.01 --grow
volgroup rhel pv.01
logvol / --vgname=rhel --fstype=xfs --size=10000 --name=root

ostreecontainer --url quay.io/mrguitar/microshift-bootc:latest	--no-signature-verification

firewall --disabled
services --enabled=sshd
user --name=core --groups=wheel --iscrypted --password=$6$3OrUXJfD.64WiZl2$4/oBFyFgIyPI6LdLCbE.h99YBrFa..pC3x3WlHNH8mUf4ssZmhlhy17CHc0n3kAvHvWecpqunVOd/4kOGB7Ms.
# Only inject a SSH key for root
rootpw --iscrypted locked
# Add your example SSH key here!
#sshkey --username root "ssh-ed25519 <key> demo@example.com"
sshkey --username core "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6M7NmgtRZkn08Dkyu8xMP0mYDSzmN1qeMoWp43Sv8fmASjLUj8XE+cC3hyvUmzqJwEv0OPWqq9a8nYdye1wMBk0xRTE9lVlAUF4FZwHw1yBXYMb6h/oTQ69eF2YxnVsrk6W6ggMfxHnLa6LHCHzPQrp9SyhVg/jQAdnF+qoQdS2ZynRWY/fnQg05obMff0+gQwolbrTUF3a9JDbwUkrFXwSGVvC2kMEgAhcd9Ii1iPw186A8XUXQS1bDXo+QjdCk4Gtm0CwMCkVdhJImNqXV6/Es3znXFEUaw1VPWx9Vhx3Q/BM3wmDEXQiXHppJ4zT+BzKXuCH+LB3bbXrR+oqAmvSdG4uu7vcMdy/9bEtOd90uv9xs51CLFEzMPTN6zz8V/7nZLvrRWjL5k1F3cSxKvCirdb26uSDLSHqu7qCKXVdn0LShgHA0FSzifyA14w5WR9/GG09DQYiVPaYUwNPk2u9tYPPJsgbJFMyCbttoTcshKkgEXIZesxIZwL5UgYS8= bbreard@comacho"
sshkey --username root "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6M7NmgtRZkn08Dkyu8xMP0mYDSzmN1qeMoWp43Sv8fmASjLUj8XE+cC3hyvUmzqJwEv0OPWqq9a8nYdye1wMBk0xRTE9lVlAUF4FZwHw1yBXYMb6h/oTQ69eF2YxnVsrk6W6ggMfxHnLa6LHCHzPQrp9SyhVg/jQAdnF+qoQdS2ZynRWY/fnQg05obMff0+gQwolbrTUF3a9JDbwUkrFXwSGVvC2kMEgAhcd9Ii1iPw186A8XUXQS1bDXo+QjdCk4Gtm0CwMCkVdhJImNqXV6/Es3znXFEUaw1VPWx9Vhx3Q/BM3wmDEXQiXHppJ4zT+BzKXuCH+LB3bbXrR+oqAmvSdG4uu7vcMdy/9bEtOd90uv9xs51CLFEzMPTN6zz8V/7nZLvrRWjL5k1F3cSxKvCirdb26uSDLSHqu7qCKXVdn0LShgHA0FSzifyA14w5WR9/GG09DQYiVPaYUwNPk2u9tYPPJsgbJFMyCbttoTcshKkgEXIZesxIZwL5UgYS8= bbreard@comacho"

reboot

# Workarounds until https://github.com/rhinstaller/anaconda/pull/5298/ lands
bootloader --location=none --disabled
%post --erroronfail
set -euo pipefail
# Work around anaconda wanting a root password
passwd -l root
rootdevice=$(findmnt -nv -o SOURCE /)
device=$(lsblk -n -o PKNAME ${rootdevice})
/usr/bin/bootupctl backend install --auto --with-static-configs --device /dev/${device} /
%end
