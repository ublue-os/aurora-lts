#!/usr/bin/env bash

dnf install -y \
    epel-release


dnf config-manager --set-enabled \
    crb
