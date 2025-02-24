ARG MAJOR_VERSION="${MAJOR_VERSION:-stream10}"
FROM ghcr.io/ublue-os/config:latest@sha256:9dce9d52ba90b418d768a65486c30be9fcf4b4f54ceb787602be6776b749ba88 AS config
FROM quay.io/centos-bootc/centos-bootc:$MAJOR_VERSION

# ARM should be handled by $(arch)
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

RUN /var/tmp/build_scripts/10-repos.sh
RUN /var/tmp/build_scripts/20-core.sh
RUN /var/tmp/build_scripts/30-desktop.sh
RUN /var/tmp/build_scripts/40-utils.sh
RUN /var/tmp/build_scripts/50-branding.sh
RUN /var/tmp/build_scripts/60-prune.sh