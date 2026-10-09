# Clean up Terragrunt completions in Bash and Zsh during Conda deactivation.
# Remove only unchanged registrations owned by this environment.

if [ -n "${_CONDA_TERRAGRUNT_COMPLETION_PREFIX:-}" ] &&
    [ "${_CONDA_TERRAGRUNT_COMPLETION_PREFIX}" = "${CONDA_PREFIX:-}" ]; then
    if [ -n "${BASH_VERSION:-}" ]; then
        if [ "$(complete -p terragrunt 2>/dev/null)" = "${_CONDA_TERRAGRUNT_COMPLETION_RULE:-}" ]; then
            complete -r terragrunt 2>/dev/null || true
        fi
    elif [ "${ZSH_VERSION+x}" = x ]; then
        # Retain the function; other command mappings may reference it.
        if [ "${_comps[terragrunt]-}" = _terragrunt ]; then
            compdef -d terragrunt 2>/dev/null || true
        fi
    fi
    unset _CONDA_TERRAGRUNT_COMPLETION_PREFIX _CONDA_TERRAGRUNT_COMPLETION_RULE
fi
