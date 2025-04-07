function setup_finder
    log (printIn red "--- Setting up Finder ---")

    log "Enabled path bar"
    defaults write com.apple.finder "ShowPathbar" -bool "true"

    log "Enabled empty trash after 30 days"
    defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

    log "Default search to current folder"
    # SCcf: Current Folder, SCev: Mac, SCsp: Previous Search Scope
    defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

    log "Enabled title bar icons"
    defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
end
