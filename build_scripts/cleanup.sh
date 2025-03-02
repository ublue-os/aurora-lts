#!/usr/bin/env bash


set -euo


shopt -s extglob


rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
rm -rf /var/tmp
dnf clean all


cp -avf /usr/etc/. /etc
rm -rvf /usr/etc


bootc container lint
