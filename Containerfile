ARG MAJOR_VERSION="${MAJOR_VERSION:-stream10}"
FROM ghcr.io/ublue-os/config:latest@sha256:b7464c991152399a40ff5ce8991b3456c3bc0622cdbe51ca247cac8671b103ca AS config
FROM quay.io/centos-bootc/centos-bootc@sha256:165e9103b7dffb108822488f5f631ea4ce73e75c76a8015aabf101afec1d9352

ARG ENABLE_DX="${ENABLE_DX:-0}"
ARG ENABLE_HWE="${ENABLE_HWE:-0}"
ARG ENABLE_GDX="${ENABLE_GDX:-0}"
ARG IMAGE_NAME="${IMAGE_NAME:-aurora}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR:-ublue-os}"
ARG MAJOR_VERSION="${MAJOR_VERSION:-lts}"
ARG SHA_HEAD_SHORT="${SHA_HEAD_SHORT:-}"

COPY system_files /
COPY system_files_overrides /var/tmp/system_files_overrides
COPY build_scripts /var/tmp/build_scripts
COPY build_scripts_overrides /var/tmp/build_scripts_overrides

RUN ARCH=$(arch) /var/tmp/build_scripts/build.sh
