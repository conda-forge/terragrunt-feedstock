#!/usr/bin/env bash
set -euxo pipefail

go install -v -buildvcs=false -ldflags "-X github.com/gruntwork-io/terragrunt/internal/version.Version=v${PKG_VERSION}" .

# Chroma's combined MIT/OFL license is not recognized by go-licenses.
go-licenses save . --save_path=library_licenses --ignore=github.com/alecthomas/chroma/v2
chroma_module_dir=$(go list -m -f '{{.Dir}}' github.com/alecthomas/chroma/v2)
cp "${chroma_module_dir}/COPYING" library_licenses/chroma-COPYING

# Terragrunt completes dynamically via COMP_LINE; it has no script generator.
mkdir -p "${PREFIX}/share/bash-completion/completions" \
    "${PREFIX}/share/zsh/site-functions" \
    "${PREFIX}/share/fish/vendor_completions.d"
cp "${RECIPE_DIR}/completions/terragrunt.bash" "${PREFIX}/share/bash-completion/completions/terragrunt"
cp "${RECIPE_DIR}/completions/_terragrunt" "${PREFIX}/share/zsh/site-functions/_terragrunt"
cp "${RECIPE_DIR}/completions/terragrunt.fish" "${PREFIX}/share/fish/vendor_completions.d/terragrunt.fish"

for action in activate deactivate; do
    mkdir -p "${PREFIX}/etc/conda/${action}.d"
    cp "${RECIPE_DIR}/completions/${action}.sh" "${PREFIX}/etc/conda/${action}.d/terragrunt.sh"
    cp "${RECIPE_DIR}/completions/${action}.fish" "${PREFIX}/etc/conda/${action}.d/terragrunt.fish"
done
