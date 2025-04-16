#!/usr/bin/env fish

# https://macos-defaults.com
# https://github.com/cpressland/dots/blob/main/macos_bootstrap.sh


for module in (/bin/ls ./modules/*.fish)
    source $module
end

setup_dock
setup_safari
setup_finder

printf "\n"
log "Finished with $errCount error[s]." -n
