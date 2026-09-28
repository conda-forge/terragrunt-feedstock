#!/usr/bin/env bash
# Test Bash completion registration, cleanup, and preservation of user rules.
# Source the installed hooks directly using the package test prefix.

export CONDA_PREFIX="$PREFIX"
activate_hook="$PREFIX/etc/conda/activate.d/terragrunt.sh"
deactivate_hook="$PREFIX/etc/conda/deactivate.d/terragrunt.sh"

# Registration and cleanup.
source "$activate_hook"
complete -p terragrunt

source "$deactivate_hook"
if complete -p terragrunt 2>/dev/null; then
    exit 1
fi

# Preserve rules registered before activation.
complete -W user_choice terragrunt
source "$activate_hook"
source "$deactivate_hook"
[[ "$(complete -p terragrunt)" == *user_choice* ]]

# Preserve replacements registered during activation.
complete -r terragrunt
source "$activate_hook"
complete -W replacement_choice terragrunt
source "$deactivate_hook"
[[ "$(complete -p terragrunt)" == *replacement_choice* ]]
