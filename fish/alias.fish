#script-alias
alias lofi=$HOME/Documents/scripts/lofi
alias nfetch=$HOME/Documents/scripts/nerdfetch
#-------------------------------------------------------------------
alias vim="nvim"
alias hx="helix"
alias jshell="/home/sumanth0x637/Documents/JShell_jdk20+36_linux/bin/jshell"
alias dnote="~/Documents/scripts/dnote"
alias so="~/Documents/scripts/so"
alias ytfzf="~/Documents/vsprojects/python/yt_searcher/ytfzf"
alias pyt="~/Documents/vsprojects/python/yt_searcher/pyt.py"
alias neofetch="neofetch --ascii ~/.config/neofetch/logo"
alias get_proxy="~/Documents/proxy/get_one.py"
alias get_ip="~/Documents/vsprojects/python/get_ip.py"
alias agg="~/Documents/scripts/agg --font-dir '/usr/share/fonts/TTF' --font-family 'JetBrainsMono Nerd Font' --fps-cap 120 --font-size 16"
alias pvpn="protonvpn-cli"
alias jnb="jupyter notebook --no-browser"
alias jlnb="jupyter-lab --no-browser"
alias cls="clear"
alias save="source ~/.config/fish/config.fish"
alias pbpaste="xsel -ob"
alias pbclear="xsel -cb"
alias pbcopy="xsel -ib"
alias ccwd="pwd | wl-copy"
alias fishconfig="$EDITOR ~/.config/fish/config.fish"
alias fishalias="$EDITOR ~/.config/fish/alias.fish"
alias fishfnc="$EDITOR ~/.config/fish/cust_functions.fish"
#alias update_soft="sudo dnf update -y && sudo dnf upgrade -y"
alias alacconfig="$EDITOR ~/.config/alacritty/alacritty.yml"
alias please="sudo"
alias e="dolphin"
#alias e="nautilus"
# alias update_ship="curl -sS https://starship.rs/install.sh | sh"
alias starship_config="$EDITOR ~/.config/starship.toml"
alias ls="exa -la -F --icons -h --color=always --git -G"
alias lst="exa -la -F --icons -h --color=always --git -T"
alias ping="gping"
alias du="dust"
alias df="duf"
alias ps="procs"
alias kittyconfig="$EDITOR ~/.config/kitty/kitty.conf"
alias icat="kitty +kitten icat"
alias kdiff="kitty +kitten diff"
alias cd..="cd .."
alias rec="asciinema rec" #specify a file name
alias play="asciinema play"
#alias logout="qdbus org.kde.ksmserver /KSMServer logout 0 0 0"
alias dir="dir --color"
alias vdir="vdir --color"
alias mex="chmod +x"
alias cat="bat"
alias cb="links"
alias cblu="links -lookup"
alias map="mapscii"
#==================================pacman && paru=========================================#
alias S="sudo pacman -S"
alias Sy="sudo pacman -Sy"
alias Syy="sudo pacman -Syy"
alias Ss="pacman -Ss"
alias U="sudo pacman -U"
alias Q="pacman -Q"
alias Qe="pacman -Qe" #installed by me
alias Qn="pacman -Qn" #installed from main repo
alias Qm="pacman -Qm" #installed from AUR
alias Qdt="pacman -Qdt" #un-needed dependencies
alias Qs="pacman -Qs" #search local
alias Rs="sudo pacman -Rs" #remove dependencies as well
alias Rsn="sudo pacman -Rsn" #remove config files too
alias Syu="sudo pacman -Syu"
alias Syyu="sudo pacman -Syyu"
alias Syyunc="sudo pacman -Syyu --noconfirm"
alias Sql="pacman -Sql" #packages installed from specific repo
alias pacman_conf="sudo nvim /etc/pacman.conf"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias pS="paru"
alias pSs="paru -Ss"
#===========================================================================================#




