#!/usr/bin/env bash

dnf config-manager --save \
	--setopt=exclude=PackageKit,PackageKit-command-not-found,rootfiles

dnf install -y \
	epel-release

dnf config-manager --set-enabled \
	crb

dnf remove -y subscription-manager

dnf config-manager --add-repo \
	"https://copr.fedorainfracloud.org/coprs/ublue-os/packages/repo/epel-${MAJOR_VERSION_NUMBER}/ublue-os-packages-epel-${MAJOR_VERSION_NUMBER}.repo"
dnf config-manager --set-disabled \
	copr:copr.fedorainfracloud.org:ublue-os:packages

dnf config-manager --add-repo \
	"https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/centos-stream-${MAJOR_VERSION_NUMBER}/che-nerd-fonts-centos-stream-${MAJOR_VERSION_NUMBER}.repo"
dnf config-manager --set-disabled \
	copr:copr.fedorainfracloud.org:che:nerd-fonts

dnf install -y \
    centos-release-hyperscale-kernel
dnf config-manager \
    --set-disabled "centos-hyperscale,centos-hyperscale-kernel"
