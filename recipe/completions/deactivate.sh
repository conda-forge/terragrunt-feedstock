# Only remove a rule that this environment registered.
if [ -n "${_CONDA_TERRAGRUNT_COMPLETION_PREFIX:-}" ] &&
    [ "${_CONDA_TERRAGRUNT_COMPLETION_PREFIX}" = "${CONDA_PREFIX:-}" ]; then
    if [ -n "${BASH_VERSION:-}" ]; then
        complete -r terragrunt 2>/dev/null || true
    elif [ -n "${ZSH_VERSION:-}" ]; then
        compdef -d terragrunt 2>/dev/null || true
    fi
    unset _CONDA_TERRAGRUNT_COMPLETION_PREFIX
fi
