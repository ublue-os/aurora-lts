#!/usr/bin/env bash

set -xeu pipefail

copy_variant() {
	VARIANT=$1
	printf "::group:: ===COPYING ${VARIANT}===\n"
	cp -afrv "/var/tmp/system_files_overrides/${VARIANT}/." /
	cp -afrv "/var/tmp/system_files_overrides/${ARCH}-${VARIANT}/." /
	cp -afrv "/var/tmp/build_scripts_overrides/${VARIANT}/." /var/tmp/build_scripts/
	cp -afrv "/var/tmp/build_scripts_overrides/${ARCH}-${VARIANT}/." /var/tmp/build_scripts/
	printf "::endgroup::\n"
}

# Copy directory
cp -frv "/var/tmp/build_scripts_overrides/shared" /var/tmp/build_scripts/

printf "::group:: ===COPYING ${ARCH}===\n"
cp -afrv "/var/tmp/system_files_overrides/${ARCH}"/. /
cp -afrv "/var/tmp/build_scripts_overrides/${ARCH}"/. /var/tmp/build_scripts/

if [ "$ENABLE_DX" == "1" ]; then
	copy_variant dx
fi

if [ "$ENABLE_GDX" == "1" ]; then
	copy_variant gdx
fi

if [ "$ENABLE_HWE" == "1" ]; then
	copy_variant hwe
fi

printf "::endgroup::\n"

MAJOR_VERSION_NUMBER="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID')"
export MAJOR_VERSION_NUMBER

cd /var/tmp/build_scripts
for script in ./*.sh; do
	cd /var/tmp/build_scripts
	printf "::group:: ===RUNNING ${script}===\n"
	${script} || (printf "Failed to run ${script}\n" && exit 1)
	printf "::endgroup::\n"
done
