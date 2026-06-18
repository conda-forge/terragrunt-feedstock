if [ -n "${BASH_VERSION:-}" ] || [ -n "${ZSH_VERSION:-}" ]; then
    complete -r terragrunt 2>/dev/null || true
fi
