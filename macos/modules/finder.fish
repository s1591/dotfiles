function setup_finder
    log (printIn red "--- Setting up Finder ---") -n

    defaults write com.apple.finder "ShowPathbar" -bool "true"
    log "Enabled path bar"

    defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
    log "Enabled empty trash after 30 days"

    # SCcf: Current Folder, SCev: Mac, SCsp: Previous Search Scope
    defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
    log "Default search to current folder"

    defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
    log "Enabled title bar icons"
end
