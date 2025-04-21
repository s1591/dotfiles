function setup_dock
    log "Setting up Dock" --title

    defaults write com.apple.dock "autohide" -bool "true" &> /dev/null
    log "Enabled autohide"

    defaults write com.apple.dock "show-recents" -bool "false" &> /dev/null
    log "Disabled recent applications"

    defaults write com.apple.dock "mineffect" -string "genie" &> /dev/null
    log "Made genie the default minimization effect"

    defaults write com.apple.dock "tilesize" -int "62" &> /dev/null
    log "Set dock icon size to 62px"

    defaults write com.apple.dock "magnification" -bool "true" &> /dev/null
    log "Enabled magnification"

    defaults write com.apple.dock "minimize-to-application" -bool "true" &> /dev/null
    log "Enabled minimize to application"

    defaults write com.apple.dock "show-process-indicators" -bool "true" &> /dev/null
    log "Enabled process indicators"

    killall Dock &> /dev/null
    log "Restarted Dock"
end
