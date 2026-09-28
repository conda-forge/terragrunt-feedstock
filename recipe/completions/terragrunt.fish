# Enable Terragrunt argument completion in Fish.
# Translate the command buffer into COMP_LINE and request candidates on demand.

function __complete_terragrunt
    # Keep embedded newlines in a single exported value.
    set -lx COMP_LINE (commandline -cp | string collect)
    # A trailing space marks an empty argument for Terragrunt.
    set -l token (commandline -ct)
    if test -z "$token"
        set COMP_LINE "$COMP_LINE "
    end
    terragrunt
end
# Generate candidates on demand; disable Fish's default filename completion.
complete -f -c terragrunt -a "(__complete_terragrunt)"
