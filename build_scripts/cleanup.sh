#!/usr/bin/env bash


set -euo


shopt -s extglob


rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
rm -rf /var/tmp
dnf clean all


bootc container lint
