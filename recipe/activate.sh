if [ -n "${BASH_VERSION:-}" ]; then
    complete -C terragrunt terragrunt
elif [ -n "${ZSH_VERSION:-}" ]; then
    autoload -U +X bashcompinit && bashcompinit
    complete -C terragrunt terragrunt
fi
