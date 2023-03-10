#!/bin/bash

# auto get modules in installer folder
export cm_user_modules=($(ls "$1/bootstrap/installer/"*.sh | xargs -n1 basename | sed 's/\.[^.]*$//'))

# or you can specify the modules list
# export cm_user_modules=(
#     pnpm
# )
