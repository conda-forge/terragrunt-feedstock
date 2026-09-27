# Only remove a rule that this environment registered.
if set -q _CONDA_TERRAGRUNT_COMPLETION_PREFIX; and test "$_CONDA_TERRAGRUNT_COMPLETION_PREFIX" = "$CONDA_PREFIX"
    complete -e -c terragrunt
    functions -e __complete_terragrunt
    set -e _CONDA_TERRAGRUNT_COMPLETION_PREFIX
end
