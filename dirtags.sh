# script to use with the following command at the root of your project:
# find * -type d -exec ~/dotfiles/dirtags.sh {} \; && ctags -R


#!/bin/sh
cd $1
ctags *

# usage:
# C-] - go to definition
# C-T - Jump back from the definition.
# C-W C-] - Open the definition in a horizontal split
# Ctrl-Left_MouseClick - Go to definition
# Ctrl-Right_MouseClick - Jump back from definition


