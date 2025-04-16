function setup_finder
    log "Setting up Finder" -t

    defaults write com.apple.finder "ShowPathbar" -bool "true" &> /dev/null
    log "Enabled path bar"

    defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true" &> /dev/null
    log "Enabled empty trash after 30 days"

    # SCcf: Current Folder, SCev: Mac, SCsp: Previous Search Scope
    defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf" &> /dev/null
    log "Default search to current folder"

    defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true" &> /dev/null
    log "Enabled title bar icons"
end
