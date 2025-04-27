function setup_menubar
    log "Setting up Menubar" --title

    defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "true"
    log "Enabled flash date seperator"

    killall SystemUIServer
    log "Restarted SystemUIServer"
end
