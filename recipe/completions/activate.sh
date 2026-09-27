# Leave existing completion rules alone, including those from an outer environment.
if [ -n "${BASH_VERSION:-}" ]; then
    if ! complete -p terragrunt >/dev/null 2>&1; then
        source "${CONDA_PREFIX}/share/bash-completion/completions/terragrunt" &&
            _CONDA_TERRAGRUNT_COMPLETION_PREFIX="${CONDA_PREFIX}"
    fi
elif [ -n "${ZSH_VERSION:-}" ]; then
    if ! typeset -f compdef >/dev/null 2>&1 || [ -z "${_comps[terragrunt]-}" ]; then
        if ! typeset -f compdef >/dev/null 2>&1; then
            autoload -Uz compinit && compinit -D -i || return
        fi
        autoload -Uz "${CONDA_PREFIX}/share/zsh/site-functions/_terragrunt" &&
            compdef _terragrunt terragrunt &&
            _CONDA_TERRAGRUNT_COMPLETION_PREFIX="${CONDA_PREFIX}"
    fi
fi
