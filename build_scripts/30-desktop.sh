#!/usr/bin/env bash

set -xeu

dnf install -y --nobest \
	@"KDE Plasma Workspaces" \
	falkon \
 	kcalc \
  	kolourpaint \
  	okular

systemctl enable \
	sddm.service

dnf install -y \
	--enablerepo copr:copr.fedorainfracloud.org:che:nerd-fonts \
	nerd-fonts
