#!/usr/bin/env bash

set -xeu

dnf install -y --nobest \
	@"KDE Plasma Workspaces" \
	falkon \
 	plasma-browser-integration

systemctl enable \
	sddm.service

dnf install -y \
	--enablerepo copr:copr.fedorainfracloud.org:che:nerd-fonts \
	nerd-fonts
