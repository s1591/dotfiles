set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin /usr/local/go/bin $HOME/.cargo/bin $HOME/.dotnet/tools /usr/lib/go/src $HOME/go/bin $PYENV_ROOT/bin /home/sumanth0x637/Documents/lua-ls/lua-language-server-3.7.4-linux-x64/bin $fish_user_paths
#set PATH $PATH:$HOME/.local/bin:$HOME/.emacs.d/bin
set EDITOR "nvim"
# set -Ux SUDO_ASKPASS "/usr/bin/ksshaskpass"
set -Ux PYENV_ROOT $HOME/.pyenv
set DOTNET_ROOT	"/usr/share/dotnet/sdk"
set DOTFILES "$HOME/Documents/dotfiles"
set WINEPREFIX "$HOME/.wine"
set SEARXNG_SETTINGS_PATH "/etc/searxng/settings.yml"
#set -gx  LC_ALL en_US.UTF-8
set --universal FZF_DEFAULT_COMMAND 'fd'
set -Ux FZF_DEFAULT_OPTS "--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"

set fish_greeting
fish_default_key_bindings #supress vim
# '⋊> '

###### SET MANPAGER ##########
### Uncomment only one of these!

### "bat" as manpager
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
# set -x MANPAGER "nvim -c 'set ft=man' -"

#if [ (math (random)'%2') -eq 1 ]
#    colorscript -r
#else
#    $HOME/Documents/tmp_runes/rune -r
#end

source ~/.config/fish/alias.fish
source ~/.config/fish/cust_functions.fish
source ~/.config/fish/conf.d/nix.fish

starship init fish | source
