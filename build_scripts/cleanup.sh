#!/usr/bin/env bash


set -euo


shopt -s extglob


# shellcheck disable=SC2114
rm -rf /var && mkdir -p /var

dnf clean all


cp -avf /usr/etc/. /etc
rm -rvf /usr/etc


bootc container lint
