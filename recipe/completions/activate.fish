# Enable Terragrunt completions in Fish during Conda activation.
# Preserve existing rules and track registrations owned by this environment.

if not complete -c terragrunt | string length -q
    # Snapshot the rule set for deactivation; collect preserves multiline output.
    source "$CONDA_PREFIX/share/fish/vendor_completions.d/terragrunt.fish"
    and set -g _CONDA_TERRAGRUNT_COMPLETION_RULE (complete -c terragrunt | string collect)
    and set -g _CONDA_TERRAGRUNT_COMPLETION_PREFIX "$CONDA_PREFIX"
end
