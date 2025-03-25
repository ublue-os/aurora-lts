#!/usr/bin/env bash

set -xeu

dnf install -y \
	@development \
	distrobox \
	distribution-gpg-keys \
	fastfetch \
	fpaste \
	just \
	powertop \
	tuned-ppd

dnf install -y \
	--enablerepo copr:copr.fedorainfracloud.org:ublue-os:packages \
	ublue-fastfetch \
	ublue-os-luks \
	ublue-os-signing \
	ublue-os-udev-rules \
	ublue-os-update-services \
	ublue-polkit-rules

# shellcheck disable=SC2016
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/etc/bashrc
