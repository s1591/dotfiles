#!/usr/bin/env fish

# https://macos-defaults.com
# inspired from https://github.com/cpressland/dots/blob/main/macos_bootstrap.sh


for module in (/bin/ls ./modules/*.fish)
    source $module
end

setup_dock
setup_safari
setup_finder
setup_menubar

printf "\n"
log "Finished with $errCount error[s]." --nomark
