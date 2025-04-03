#!/usr/bin/env bash

dnf config-manager \
    --set-enabled "centos-hyperscale,centos-hyperscale-kernel"

./shared/nvidia.sh

dnf config-manager \
    --set-disabled "centos-hyperscale,centos-hyperscale-kernel"
