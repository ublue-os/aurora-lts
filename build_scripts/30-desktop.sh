#!/usr/bin/env bash


set -xeu


dnf install -y --nobest \
	@"KDE Plasma Workspaces"


systemctl enable \
    sddm.service
