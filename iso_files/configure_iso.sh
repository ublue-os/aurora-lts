#!/usr/bin/env bash

YAI_LATEST=$(curl -fSsL https://api.github.com/repos/ublue-os/yai/releases/latest | jq -r --arg arch $(arch) '.assets[] | select(.name | match("yai-.*."+$arch+".rpm")) | .browser_download_url')
dnf install -y $YAI_LATEST