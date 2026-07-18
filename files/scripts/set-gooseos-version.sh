#!/usr/bin/env bash
set -euo pipefail

OS_RELEASE="/usr/lib/os-release"
BUILD_DATE="$(date -u +%Y-%m-%d)"

# Load base-image metadata, including IMAGE_VERSION and RELEASE_TYPE.
source "${OS_RELEASE}"

case "${IMAGE_NAME:?BlueBuild did not provide IMAGE_NAME}" in
    *intel*)
        EDITION="Intel"
        ;;
    *nvidia*)
        EDITION="NVIDIA"
        ;;
    *)
        echo "Cannot determine GooseOS edition from IMAGE_NAME=${IMAGE_NAME}" >&2
        exit 1
        ;;
esac

IMAGE_VERSION="${IMAGE_VERSION:?IMAGE_VERSION is missing from ${OS_RELEASE}}"
RELEASE_CHANNEL="${RELEASE_TYPE:-stable}"

PRETTY_NAME_VALUE="GooseOS ${EDITION} — build ${BUILD_DATE} — version ${IMAGE_VERSION} — ${RELEASE_CHANNEL}"

sed -i \
    -e 's/^NAME=.*/NAME="GooseOS"/' \
    -e 's/^ID=.*/ID=gooseos/' \
    -e "s|^PRETTY_NAME=.*|PRETTY_NAME=\"${PRETTY_NAME_VALUE}\"|" \
    -e "s|^DEFAULT_HOSTNAME=.*|DEFAULT_HOSTNAME=\"gooseos\"|" \
    "${OS_RELEASE}"

if grep -q '^BUILD_DATE=' "${OS_RELEASE}"; then
    sed -i "s/^BUILD_DATE=.*/BUILD_DATE=\"${BUILD_DATE}\"/" "${OS_RELEASE}"
else
    printf 'BUILD_DATE="%s"\n' "${BUILD_DATE}" >> "${OS_RELEASE}"
fi

printf 'Generated GooseOS identity:\n'
printf '  IMAGE_NAME=%s\n' "${IMAGE_NAME}"
printf '  EDITION=%s\n' "${EDITION}"
printf '  IMAGE_VERSION=%s\n' "${IMAGE_VERSION}"
printf '  BUILD_DATE=%s\n' "${BUILD_DATE}"
printf '  PRETTY_NAME=%s\n' "${PRETTY_NAME_VALUE}"
