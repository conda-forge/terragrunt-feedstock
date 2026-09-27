#!/usr/bin/env zsh
export CONDA_PREFIX="$PREFIX"
activate_hook="$PREFIX/etc/conda/activate.d/terragrunt.sh"
deactivate_hook="$PREFIX/etc/conda/deactivate.d/terragrunt.sh"

# Activation registers a completion function that Zsh can load.
source "$activate_hook"
[[ "${_comps[terragrunt]}" == _terragrunt ]]
autoload +X _terragrunt

# Deactivation removes the rule registered by the hook.
source "$deactivate_hook"
[[ -z "${_comps[terragrunt]-}" ]]

# An existing user rule survives activation and deactivation.
compdef _files terragrunt
source "$activate_hook"
source "$deactivate_hook"
[[ "${_comps[terragrunt]}" == _files ]]
