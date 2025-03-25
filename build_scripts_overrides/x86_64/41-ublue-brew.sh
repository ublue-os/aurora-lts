#!/usr/bin/env bash

set -xeu

dnf install -y \
	--enablerepo copr:copr.fedorainfracloud.org:ublue-os:packages \
	ublue-brew
