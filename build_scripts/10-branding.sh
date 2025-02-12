#!/usr/bin/env bash

set -xeuo pipefail

IMAGE_REF="ostree-image-signed:docker://ghcr.io/${IMAGE_VENDOR}/${IMAGE_NAME}"
IMAGE_INFO="/usr/share/ublue-os/image-info.json"
IMAGE_FLAVOR="main"

cat >$IMAGE_INFO <<EOF
{
  "image-name": "${IMAGE_NAME}",
  "image-ref": "${IMAGE_REF}",
  "image-flavor": "${IMAGE_FLAVOR}",
  "image-vendor": "${IMAGE_VENDOR}",
  "image-tag": "${MAJOR_VERSION_NUMBER}",
  "centos-version": "${MAJOR_VERSION_NUMBER}"
}
EOF

OLD_PRETTY_NAME="$(sh -c '. /usr/lib/os-release ; echo $NAME $VERSION')"
IMAGE_PRETTY_NAME="Aurora Helium (LTS)"
IMAGE_LIKE="rhel centos"
HOME_URL="https://getaurora.dev/"
DOCUMENTATION_URL="https://docs.getaurora.dev/"
SUPPORT_URL="https://github.com/ublue-os/aurora-lts/issues/"
BUG_SUPPORT_URL="https://github.com/ublue-os/aurora-lts/issues/"
CODE_NAME="Helium"

# OS Release File (changed in order with upstream)
sed -i -f - /usr/lib/os-release <<EOF
s/^NAME=.*/NAME=\"${IMAGE_PRETTY_NAME}\"/
s|^VERSION_CODENAME=.*|VERSION_CODENAME=\"${CODE_NAME}\"|
s/^ID=centos/ID=${IMAGE_PRETTY_NAME,}\nID_LIKE=\"${IMAGE_LIKE}\"/
s/^VARIANT_ID=.*/VARIANT_ID=${IMAGE_NAME}/
s/^PRETTY_NAME=.*/PRETTY_NAME=\"${IMAGE_PRETTY_NAME} (FROM $OLD_PRETTY_NAME)\"/
s|^HOME_URL=.*|HOME_URL=\"${HOME_URL}\"|
s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"${BUG_SUPPORT_URL}\"|
s|^CPE_NAME=\"cpe:/o:centos:centos|CPE_NAME=\"cpe:/o:universal-blue:${IMAGE_PRETTY_NAME,}|

/^REDHAT_BUGZILLA_PRODUCT=/d
/^REDHAT_BUGZILLA_PRODUCT_VERSION=/d
/^REDHAT_SUPPORT_PRODUCT=/d
/^REDHAT_SUPPORT_PRODUCT_VERSION=/d
EOF

tee -a /usr/lib/os-release <<EOF
DOCUMENTATION_URL="${DOCUMENTATION_URL}"
SUPPORT_URL="${SUPPORT_URL}"
DEFAULT_HOSTNAME="${IMAGE_PRETTY_NAME,,}"
BUILD_ID="${SHA_HEAD_SHORT:-testing}"
EOF

mkdir -p /usr/share/wallpapers
curl -o /usr/share/wallpapers/andromeda.jpg \
  https://codeberg.org/HeliumOS/wallpapers/raw/commit/861d6a6b8d192a032ba00d090e41d648e2425e63/andromeda.jpg
if [ "$(sha256sum /usr/share/wallpapers/andromeda.jpg | awk '{print $1}')" != "a3742887568d143db771faf2b6333b72d792bb165ef34add8375bbf741929853" ]; then
  exit 1
fi
