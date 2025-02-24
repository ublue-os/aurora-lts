#!/usr/bin/env bash


set -xeu


dnf remove -y \
    setroubleshoot \
    cockpit \
    krfb
