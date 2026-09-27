# Leave existing completion rules alone, including those from an outer environment.
if not complete -c terragrunt | string length -q
    source "$CONDA_PREFIX/share/fish/vendor_completions.d/terragrunt.fish"; or return
    set -g _CONDA_TERRAGRUNT_COMPLETION_PREFIX "$CONDA_PREFIX"
end
