#!/usr/bin/env bash


set -xeu


dnf install -y --nobest \
	@"KDE Plasma Workspaces"


systemctl enable \
    sddm.service


dnf install -y \
    plymouth-system-theme


dnf install -y \
    --enablerepo copr:copr.fedorainfracloud.org:che:nerd-fonts \
        nerd-fonts
