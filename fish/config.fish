set fish_greeting
fish_default_key_bindings

set -e fish_user_paths
set -U fish_user_paths /opt/homebrew/bin /opt/homebrew/sbin /usr/local/go/bin $HOME/go/bin $HOME/bin $PYENV_ROOT/bin $PYENV_ROOT/shims $HOME/Documents/scripts /opt/homebrew/opt/openjdk@21/bin/ $fish_user_paths

set -U EDITOR nvim
set -U PYENV_ROOT $HOME/.pyenv
set -U DOTNET_ROOT /usr/local/share/dotnet
set -U FZF_DEFAULT_COMMAND fd
set -U FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set config_files \
    alias.fish \
    functions.fish

for i in $config_files
    source $__fish_config_dir/$i
end

set -e config_files

starship init fish | source
