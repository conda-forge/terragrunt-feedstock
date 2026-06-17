#!/usr/bin/env bash
set -euxo pipefail

go install -v -ldflags "-X main.VERSION=${PKG_VERSION}" .

for change in activate deactivate; do
    mkdir -p "${PREFIX}/etc/conda/${change}.d"
    cp "${RECIPE_DIR}/${change}.sh"   "${PREFIX}/etc/conda/${change}.d/${PKG_NAME}_${change}.sh"
    cp "${RECIPE_DIR}/${change}.fish" "${PREFIX}/etc/conda/${change}.d/${PKG_NAME}_${change}.fish"
done
