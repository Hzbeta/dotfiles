#!/bin/bash

installer_dir="$1/.bootstrap/installers"

cm_user_modules=()

# auto get modules in installer folder
# need to specify the path to the chezmoi source-path
while IFS='' read -r line; do cm_user_modules+=("$line"); done < <(find "$installer_dir/"*.sh -print0 | xargs -0 -n1 basename | sed 's/\.[^.]*$//')

# or you can specify the modules list
# cm_user_modules=(
#     proxy
# )

unset installer_dir
export cm_user_modules
