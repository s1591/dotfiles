function setup_safari
    log "Setting up Safari" -t

    defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true" &> /dev/null
    log "Showing full URL in safari"

    defaults write com.apple.Safari "PreloadTopHit" -bool "false" &> /dev/null
    log "Disabled preload top hit"

    defaults write com.apple.Safari "AutoOpenSafeDownloads" -bool "false" &> /dev/null
    log "Disabled open safe files after downloading"

    defaults write com.apple.Safari "HistoryAgeInDaysLimit" -int "1" &> /dev/null
    log "Limited History to 1 day"

    defaults write com.apple.Safari "ShowOverlayStatusBar" -int "1" &> /dev/null
    log "Toggled Status Bar"
end
