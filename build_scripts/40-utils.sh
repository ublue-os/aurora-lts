#!/usr/bin/env bash


set -xeu


dnf install -y \
    distrobox \
	distribution-gpg-keys \
	fastfetch \
	fpaste \
	just \
	powertop \
	tuned-ppd
