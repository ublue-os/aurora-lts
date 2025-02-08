#!/usr/bin/env bash

set -euox pipefail

# This is the base for a minimal GNOME system on CentOS Stream.

# This thing slows down downloads A LOT for no reason
dnf remove -y subscription-manager

# The base images take super long to update, this just updates manually for now
dnf -y update
dnf -y install 'dnf-command(versionlock)'
dnf versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt

dnf config-manager --set-enabled crb
dnf -y install "https://dl.fedoraproject.org/pub/epel/epel-release-latest-$MAJOR_VERSION_NUMBER.noarch.rpm"

# Multimidia codecs
dnf -y install @multimedia gstreamer1-plugins-{bad-free,bad-free-libs,good,base} lame{,-libs} libjxl

# `dnf group info Workstation` without KDE
dnf group install -y --nobest \
	-x rsyslog* \
	-x cockpit \
	-x cronie* \
	-x crontabs \
	-x PackageKit \
	-x PackageKit-command-not-found \
	"Common NetworkManager submodules" \
	"Core" \
	"Fonts" \
	"Guest Desktop Agents" \
	"Hardware Support" \
	"Printing Client" \
	"Standard" \
	"Workstation product core"

# Minimal KDE Plasma Workspaces Group
dnf -y install \
	-x PackageKit \
	-x PackageKit-command-not-found \
	-x gnome-software-fedora-langpacks \
	"NetworkManager-adsl" \
	"centos-backgrounds" \
	@"KDE Plasma Workspaces"
	

dnf -y install \
	plymouth \
	plymouth-system-theme \
	fwupd

# This package adds "[systemd] Failed Units: *" to the bashrc startup
dnf -y remove console-login-helper-messages
