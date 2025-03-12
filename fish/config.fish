set -e fish_user_paths
set -U fish_user_paths /opt/homebrew/bin /opt/homebrew/sbin /usr/local/go/bin /Users/s1591/go/bin ~/bin $PYENV_ROOT/bin $PYENV_ROOT/shims /opt/homebrew/opt/openjdk@21/bin $HOME/Documents/scripts $fish_user_paths
set -Ux PYENV_ROOT $HOME/.pyenv
set EDITOR nvim
set --universal FZF_DEFAULT_COMMAND fd
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set fish_greeting
fish_default_key_bindings #supress vim
# '⋊> '

source ~/.config/fish/alias.fish
source ~/.config/fish/cust_functions.fish

starship init fish | source
