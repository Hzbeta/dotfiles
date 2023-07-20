#!/bin/bash

installer_dir="$1/.bootstrap/installers"

cm_user_modules=()

# auto get modules in installer folder
# need to specify the path to the chezmoi source-path
# we can use the number prefix to control the install order of the modules
# for example: 00_homebrew.sh will be installed before 01_zsh.sh
while IFS='' read -r line; do
    cm_user_modules+=("$line")
done < <(find "$installer_dir/"*.sh -print0 | xargs -0 -n1 basename)

# or we can specify the modules list
# cm_user_modules=(
#     00_nix.sh
#     01_misc-tools.sh
#     02_miniconda3.sh
#     03_pnpm.sh
#     99_zsh.sh
# )

unset installer_dir
export cm_user_modules
