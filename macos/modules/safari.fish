function setup_safari
    log (printIn red "--- Setting up Safari ---") -n

    defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"
    log "Showing full URL in safari"

    defaults write com.apple.Safari "PreloadTopHit" -bool "false"
    log "Disabled preload top hit"

    defaults write com.apple.Safari "AutoOpenSafeDownloads" -bool "false"
    log "Disabled open safe files after downloading"

    defaults write com.apple.Safari "HistoryAgeInDaysLimit" -int "1"
    log "Limited History to 1 day"

    defaults write com.apple.Safari "ShowOverlayStatusBar" -int "1"
    log "Toggled Status Bar"
end
