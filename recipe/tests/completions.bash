#!/usr/bin/env bash
export CONDA_PREFIX="$PREFIX"
activate_hook="$PREFIX/etc/conda/activate.d/terragrunt.sh"
deactivate_hook="$PREFIX/etc/conda/deactivate.d/terragrunt.sh"

# Activation registers Terragrunt completion.
source "$activate_hook"
complete -p terragrunt

# Deactivation removes the rule registered by the hook.
source "$deactivate_hook"
if complete -p terragrunt 2>/dev/null; then
    exit 1
fi

# An existing user rule survives activation and deactivation.
complete -W user_choice terragrunt
source "$activate_hook"
source "$deactivate_hook"
[[ "$(complete -p terragrunt)" == *user_choice* ]]
