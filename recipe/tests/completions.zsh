#!/usr/bin/env zsh
# Test Zsh completion registration, cleanup, and reloads across environments.
# Verify preservation of existing, replaced, and automatically discovered rules.

export CONDA_PREFIX="$PREFIX"
activate_hook="$PREFIX/etc/conda/activate.d/terragrunt.sh"
deactivate_hook="$PREFIX/etc/conda/deactivate.d/terragrunt.sh"

# Isolate hook-owned registration from compinit's automatic discovery.
autoload -Uz compinit
compinit -D -i
compdef -d terragrunt

# Registration, function loading, and cleanup.
source "$activate_hook"
[[ "${_comps[terragrunt]}" == _terragrunt ]]
autoload +X _terragrunt

source "$deactivate_hook"
[[ -z "${_comps[terragrunt]-}" ]]

# Reload the completion function from the newly activated prefix.
other_prefix=$(mktemp -d)
trap 'rm -rf -- "$other_prefix"' EXIT
mkdir -p "$other_prefix/share/zsh/site-functions"
cp "$PREFIX/share/zsh/site-functions/_terragrunt" "$other_prefix/share/zsh/site-functions/"
export CONDA_PREFIX="$other_prefix"
source "$activate_hook"
autoload +X _terragrunt
[[ "${functions_source[_terragrunt]}" == "$other_prefix/share/zsh/site-functions/_terragrunt" ]]
source "$deactivate_hook"
export CONDA_PREFIX="$PREFIX"

# Preserve rules registered before activation.
compdef _files terragrunt
source "$activate_hook"
source "$deactivate_hook"
[[ "${_comps[terragrunt]}" == _files ]]

# Preserve replacements registered during activation.
compdef -d terragrunt
source "$activate_hook"
compdef _files terragrunt
source "$deactivate_hook"
[[ "${_comps[terragrunt]}" == _files ]]

# Preserve user completions discovered during initialization.
mkdir -p "$other_prefix/user-completions"
printf '%s\n' '#compdef terragrunt' 'compadd user_choice' > "$other_prefix/user-completions/_user_terragrunt"
fpath=("$other_prefix/user-completions" $fpath)
# Force reinitialization after adding the fixture to fpath.
compdef -d terragrunt
unfunction compdef
source "$activate_hook"
[[ "${_comps[terragrunt]}" == _user_terragrunt ]]
source "$deactivate_hook"
[[ "${_comps[terragrunt]}" == _user_terragrunt ]]
