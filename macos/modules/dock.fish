function setup_dock
    log (printInRed "--- Setting up Dock ---")

    log "Enabled autohide"
    defaults write com.apple.dock "autohide" -bool "true"

    log "Disabled recent applications"
    defaults write com.apple.dock "show-recents" -bool "false"

    log "Made genie the default minimization effect"
    defaults write com.apple.dock "mineffect" -string "genie"

    log "Set dock icon size to 62px"
    defaults write com.apple.dock "tilesize" -int "62"

    log "Enabled magnification"
    defaults write com.apple.dock "magnification" -bool "true"

    log "Enabled minimize to application"
    defaults write com.apple.dock "minimize-to-application" -bool "true"

    log "Enabled process indicators"
    defaults write com.apple.dock "show-process-indicators" -bool "true"

    log "Restarted Dock"
    killall Dock
end
