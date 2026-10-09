#!/usr/bin/env fish
# Test Fish completion output, input preservation, and activation/deactivation.
# Verify that cleanup preserves existing, replaced, and additional user rules.

set -gx CONDA_PREFIX "$PREFIX"
set activate_hook "$PREFIX/etc/conda/activate.d/terragrunt.fish"
set deactivate_hook "$PREFIX/etc/conda/deactivate.d/terragrunt.fish"

# Completion suggestions after activation.
source "$activate_hook"; or exit 1
complete -C "terragrunt ru" | grep -qx run; or exit 1

# Preserve embedded newlines in COMP_LINE; a test double validates the input.
set -g expected_line "terragrunt --working-dir 'first
second' ru"
function terragrunt
    test "$COMP_LINE" = "$expected_line"; or return 1
    echo run
end
complete -C "$expected_line" | grep -qx run; or exit 1
functions -e terragrunt
set -e expected_line

# Remove unchanged registrations and their helper.
source "$deactivate_hook"; or exit 1
complete -c terragrunt | grep -q .; and exit 1
functions -q __complete_terragrunt; and exit 1

# Preserve rules registered before activation.
complete -c terragrunt -f -a user_choice
source "$activate_hook"; or exit 1
source "$deactivate_hook"; or exit 1
complete -c terragrunt | grep -q user_choice; or exit 1

# Preserve replacements registered during activation.
complete -e -c terragrunt
source "$activate_hook"; or exit 1
complete -e -c terragrunt
complete -c terragrunt -f -a replacement_choice
source "$deactivate_hook"; or exit 1
complete -c terragrunt | grep -q replacement_choice; or exit 1

# Preserve additional user rules and the helper required by retained rules.
complete -e -c terragrunt
source "$activate_hook"; or exit 1
complete -c terragrunt -f -a added_choice
source "$deactivate_hook"; or exit 1
complete -c terragrunt | grep -q added_choice; or exit 1
complete -C "terragrunt ru" | grep -qx run
