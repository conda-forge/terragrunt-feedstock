# Clean up Terragrunt completion rules and their helper on Conda deactivation.
# Preserve modified rules and registrations owned by other environments.

if set -q _CONDA_TERRAGRUNT_COMPLETION_PREFIX; and test "$_CONDA_TERRAGRUNT_COMPLETION_PREFIX" = "$CONDA_PREFIX"
    set -l current_rule (complete -c terragrunt | string collect)
    # Preserve the entire rule set and helper if any registration changed.
    if test "$current_rule" = "$_CONDA_TERRAGRUNT_COMPLETION_RULE"
        complete -e -c terragrunt
        functions -e __complete_terragrunt
    end
    set -e _CONDA_TERRAGRUNT_COMPLETION_PREFIX
    set -e _CONDA_TERRAGRUNT_COMPLETION_RULE
end
