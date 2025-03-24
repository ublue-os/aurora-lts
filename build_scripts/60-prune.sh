#!/usr/bin/env bash


set -xeu


dnf remove -y \
    setroubleshoot \
    cockpit \
    krfb \
    console-login-helper-messages


rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedora.desktop


rm -rf /usr/share/wallpapers/fedora


rm -rf /usr/share/backgrounds/*


rm -rf /usr/share/sddm/themes/01-breeze-fedora
