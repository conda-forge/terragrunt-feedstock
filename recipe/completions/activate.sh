# Enable Terragrunt completions in Bash and Zsh during Conda activation.
# Preserve existing rules and track registrations owned by this environment.

if [ -n "${BASH_VERSION:-}" ]; then
    if ! complete -p terragrunt >/dev/null 2>&1; then
        # Save the registration to detect subsequent user changes.
        source "${CONDA_PREFIX}/share/bash-completion/completions/terragrunt" &&
            _CONDA_TERRAGRUNT_COMPLETION_RULE=$(complete -p terragrunt) &&
            _CONDA_TERRAGRUNT_COMPLETION_PREFIX="${CONDA_PREFIX}"
    fi
elif [ -n "${ZSH_VERSION:-}" ]; then
    if ! typeset -f compdef >/dev/null 2>&1; then
        # Avoid cache writes and skip insecure completion directories.
        autoload -Uz compinit && compinit -D -i
    fi &&
    # Register only after successful initialization; compinit may find a rule.
    if [ -z "${_comps[terragrunt]-}" ]; then
        # autoload does not replace definitions cached from a previous environment.
        unfunction _terragrunt 2>/dev/null || true
        autoload -Uz "${CONDA_PREFIX}/share/zsh/site-functions/_terragrunt" &&
            compdef _terragrunt terragrunt &&
            _CONDA_TERRAGRUNT_COMPLETION_PREFIX="${CONDA_PREFIX}"
    fi
fi
