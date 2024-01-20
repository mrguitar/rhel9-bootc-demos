text

# Basic partitioning
clearpart --all --initlabel --disklabel=gpt
part /boot     --size=1000  --fstype=ext4 --label=boot
part / --grow --fstype xfs
reqpart

ostreecontainer --url quay.io/centos-bootc/fedora-bootc:eln	--no-signature-verification
# Or: quay.io/centos-bootc/centos-bootc-dev:stream9

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

