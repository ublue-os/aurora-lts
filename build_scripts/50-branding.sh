#!/usr/bin/env bash

set -xeu

mkdir -p /etc/xdg &&
	touch /etc/xdg/system.kdeglobals

sed -i 's,https://centos.org/,https://getaurora.dev/,g' /usr/lib/os-release &&
	sed -i 's,https://issues.redhat.com/,https://github.com/ublue-os/aurora-lts/issues,g' /usr/lib/os-release &&
	sed -i 's,LOGO="fedora-logo-icon",LOGO="aurora-helium-logo-icon",g' /usr/lib/os-release &&
	sed -i 's,10 (Coughlan),10,g' /usr/lib/os-release &&
	sed -i 's,REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 10",,g' /usr/lib/os-release &&
	sed -i 's,REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream",,g' /usr/lib/os-release &&
	sed -i 's,CentOS Stream,Aurora Helium (LTS),g' /usr/lib/os-release &&
	sed -i 's,CPE_NAME="cpe:/o:centos:centos:10",CPE_NAME="cpe:/o:universal-blue:aurora-lts:10",g' /usr/lib/os-release &&
	sed -i 's,ID="centos",ID="aurora-helium",g' /usr/lib/os-release &&
	sed -i 's,ID_LIKE="rhel fedora",ID_LIKE="rhel centos fedora",g' /usr/lib/os-release &&
	sed -i 's,VENDOR_NAME="CentOS",VENDOR_NAME="Universal Blue",g' /usr/lib/os-release &&
	sed -i 's,ANSI_COLOR="0;31",ANSI_COLOR="0;38;2;60;110;180",g' /usr/lib/os-release
if [[ -n "${SHA_HEAD_SHORT:-}" ]]; then
	echo "BUILD_ID=\"$SHA_HEAD_SHORT\"" >>/usr/lib/os-release
fi

ln -sf /usr/share/icons/hicolor/scalable/distributor-logo.svg /usr/share/icons/hicolor/scalable/apps/aurora-helium-logo-icon.svg &&
	ln -sf /usr/share/icons/hicolor/scalable/distributor-logo.svg /usr/share/icons/hicolor/scalable/apps/start-here.svg &&
	ln -sf /usr/share/icons/hicolor/scalable/distributor-logo.svg /usr/share/icons/hicolor/scalable/apps/xfce4_xicon1.svg &&
	ln -sf /usr/share/icons/hicolor/scalable/distributor-logo.svg /usr/share/pixmaps/fedora-logo-sprite.svg

declare -a plasma_themes=("breeze" "breeze-dark")
declare -a icon_sizes=("16" "22" "32" "64" "96")
declare -a start_here_variants=("start-here-kde-plasma.svg" "start-here-kde.svg" "start-here-kde-plasma-symbolic.svg" "start-here-kde-symbolic.svg" "start-here-symbolic.svg")
for plasma_theme in "${plasma_themes[@]}"; do
	for icon_size in "${icon_sizes[@]}"; do
		for start_here_variant in "${start_here_variants[@]}"; do
			ln -sf \
				/usr/share/icons/hicolor/scalable/distributor-logo.svg \
				"/usr/share/icons/${plasma_theme}/places/${icon_size}/${start_here_variant}"
		done
	done
done

curl -o /var/tmp/wallpapers.tar.gz https://codeberg.org/HeliumOS/wallpapers/archive/eccec97df37d4d5aee4f23e1e57b46c0e4e6c484.tar.gz &&
	tar -xzf /var/tmp/wallpapers.tar.gz &&
	mv wallpapers /var/tmp/wallpapers

mkdir -p /usr/share/wallpapers/Andromeda/contents/images &&
	cp /var/tmp/wallpapers/andromeda.jpg /usr/share/wallpapers/Andromeda/contents/images/5338x5905.jpg &&
	cat <<EOF >>/usr/share/wallpapers/Andromeda/metadata.json
{
    "KPlugin": {
        "Authors": [
            {
                "Name": ""
            }
        ],
        "Id": "Andromeda",
        "Name": "Andromeda"
    }
}
EOF

declare -a lookandfeels=("org.kde.breeze.desktop" "org.kde.breezedark.desktop" "org.kde.breezetwilight.desktop")
for lookandfeel in "${lookandfeels[@]}"; do
	sed -i 's,Image=Next,Image=Andromeda,g' "/usr/share/plasma/look-and-feel/${lookandfeel}/contents/defaults"
done

sed -i 's,background=/usr/share/wallpapers/Next/contents/images/5120x2880.png,background=/usr/share/wallpapers/Andromeda/contents/images/5338x5905.jpg,g' /usr/share/sddm/themes/breeze/theme.conf
sed -i 's,#Current=01-breeze-fedora,Current=breeze,g' /etc/sddm.conf

dnf remove -y \
	lsb_release
rm -f /etc/redhat-release
echo "HOMEBREW_OS_VERSION='Aurora Helium (LTS)'" >>/etc/profile
