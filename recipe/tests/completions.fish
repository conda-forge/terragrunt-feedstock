#!/usr/bin/env fish
set -gx CONDA_PREFIX "$PREFIX"
set activate_hook "$PREFIX/etc/conda/activate.d/terragrunt.fish"
set deactivate_hook "$PREFIX/etc/conda/deactivate.d/terragrunt.fish"

# Activation makes "terragrunt ru" suggest "run".
source "$activate_hook"; or exit 1
complete -C "terragrunt ru" | grep -qx run; or exit 1

# Deactivation removes the rule and its helper function.
source "$deactivate_hook"; or exit 1
complete -c terragrunt | grep -q .; and exit 1
functions -q __complete_terragrunt; and exit 1

# An existing user rule survives activation and deactivation.
complete -c terragrunt -f -a user_choice
source "$activate_hook"; or exit 1
source "$deactivate_hook"; or exit 1
complete -c terragrunt | grep -q user_choice
