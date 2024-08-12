set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin /usr/local/go/bin $HOME/.cargo/bin $HOME/.dotnet/tools /usr/lib/go/src $HOME/go/bin $PYENV_ROOT/bin $HOME/.local/share/nvim/mason/bin $HOME/Documents/scripts $fish_user_paths
#set PATH $PATH:$HOME/.local/bin:$HOME/.emacs.d/bin
set EDITOR nvim
# set -Ux SUDO_ASKPASS "/usr/bin/ksshaskpass"
set -Ux PYENV_ROOT $HOME/.pyenv
set DOTNET_ROOT /usr/share/dotnet/sdk
set DOTFILES "$HOME/Documents/dotfiles"
set WINEPREFIX "$HOME/.wine"
set SEARXNG_SETTINGS_PATH "/etc/searxng/settings.yml"
#set -gx  LC_ALL en_US.UTF-8
set --universal FZF_DEFAULT_COMMAND fd
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

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

starship init fish | source
