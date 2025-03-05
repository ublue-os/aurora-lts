#!/usr/bin/env bash


set -xeu


dnf -y install 'dnf-command(versionlock)'
dnf versionlock add \
    kernel \
    kernel-devel \
    kernel-devel-matched \
    kernel-core \
    kernel-modules \
    kernel-modules-core \
    kernel-modules-extra \
    kernel-uki-virt


dnf -y update


dnf -y install \
    @multimedia \
    gstreamer1-plugins-{bad-free,bad-free-libs,good,base} lame{,-libs} \
    libjxl \
    fuse


dnf install -y --nobest \
	-x rsyslog* \
	-x cockpit \
	-x cronie* \
	-x crontabs \
	-x PackageKit \
	-x PackageKit-command-not-found \
	@"Common NetworkManager submodules" \
	@"Core" \
	@"Fonts" \
	@"Guest Desktop Agents" \
	@"Hardware Support" \
	@"Printing Client" \
	@"Standard" \
	@"Workstation product core"


dnf -y install \
	plymouth \
    plymouth-system-theme \
	fwupd


KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
