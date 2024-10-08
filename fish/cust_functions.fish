# name: sashimi prompt 
function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -g red (set_color -o red)
  set -g blue (set_color -o blue)
  set -l green (set_color -o green)
  set -g normal (set_color normal)

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set initial_indicator "$green◆"
    set status_indicator "$normal❯$cyan❯$green❯"
  else
    set initial_indicator "$red✖ $last_status"
    set status_indicator "$red❯$red❯$red❯"
  end
  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]

    if test (_git_branch_name) = 'master'
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($red$git_branch$normal)"
    else
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($blue$git_branch$normal)"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  # Notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    echo The last command took (math "$CMD_DURATION/1000") seconds.
  end

  echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace
end

function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$blue↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$red↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end
#################end prompt##################


function spark --description Sparklines
    argparse --ignore-unknown --name=spark v/version h/help m/min= M/max= -- $argv || return

    if set --query _flag_version[1]
        echo "spark, version 1.1.0"
    else if set --query _flag_help[1]
        echo "Usage: spark <numbers ...>"
        echo "       stdin | spark"
        echo "Options:"
        echo "       --min=<number>   Minimum range"
        echo "       --max=<number>   Maximum range"
        echo "       -v or --version  Print version"
        echo "       -h or --help     Print this help message"
        echo "Examples:"
        echo "       spark 1 1 2 5 14 42"
        echo "       seq 64 | sort --random-sort | spark"
    else if set --query argv[1]
        printf "%s\n" $argv | spark --min="$_flag_min" --max="$_flag_max"
    else
        command awk -v min="$_flag_min" -v max="$_flag_max" '
            {
                m = min == "" ? m == "" ? $0 : m > $0 ? $0 : m : min
                M = max == "" ? M == "" ? $0 : M < $0 ? $0 : M : max
                nums[NR] = $0
            }
            END {
                n = split("▁ ▂ ▃ ▄ ▅ ▆ ▇ █", sparks, " ") - 1
                while (++i <= NR) 
                    printf("%s", sparks[(M == m) ? 3 : sprintf("%.f", (1 + (nums[i] - m) * n / (M - m)))])
            }
        ' && echo
    end
end
#########
# Spark functions
function letters
    cat $argv | awk -vFS='' '{for(i=1;i<=NF;i++){ if($i~/[a-zA-Z]/) { w[tolower($i)]++} } }END{for(i in w) print i,w[i]}' | sort | cut -c 3- | spark | cat
    printf  '%s\n' 'abcdefghijklmnopqrstuvwxyz'  ' ' | cat
end


function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end


function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments


### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function evil
  switch $argv[1]
    case 1 
      fish_vi_key_bindings
    case 0
      fish_default_key_bindings
  end
end


function makebak
  cp $argv[1] $argv[1].bak
end


function avail
  command -v $argv[1] > /dev/null
end

function s 
	if test $argv[1] > /dev/null
		rg $argv[1]
	end
end

function o --description "open a files quickly using fzf"
	set a (fd . -H --type f | fzf --prompt="\$ " --pointer="*" --preview 'bat --color=always --style=numbers --line-range=:500 {}')	
	if test $status -eq 0 
	  switch $argv[1]
      case $argv[1]
        $argv[1] $a
      case "*"
	      $EDITOR $a
    end
	end
end


function d --description "jump to a directory quickly using fzf"
  set currDir $PWD
	switch $argv[1]
		case "h"
			set dest (fd . --type d -H | fzf --prompt="\$ " --pointer="*" --preview 'ls {}')
		case "*"
			set dest (fd . --type d | fzf --prompt="\$ " --pointer="*" --preview 'ls {}')
	end
  if test $status -eq 0
    cd $dest
  else
    cd $currDir
  end
end


function rotate
	switch $argv[1]
		case "-l"
			xrandr -o 3
		case "-r"
			xrandr -o 1
		case "-n"
			xrandr -o 0 
		case "-i"
			xrandr -o 2
		case "*"
			xrandr --help
	end
end

function test_letters --description "see how current font displays numbers, letters and some ligatures"
  switch $argv[1]
    case "a"
      set is_instant 1
    case "i"
      set is_instant 0
    case "*"
      set is_instant 0
  end
  set nums "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" 
  set alps "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" 
  set punct "!" "@" "#" "\$" "%" "^" "&" "*" "(" ")" "{" "}"
  set ligatures "--" "---" "==" "===" "!=" "!==" "=!=" "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!" "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>" "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####" "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<\$>" "<\$" "\$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--" "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>" "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|" "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~" "~@" "[||]" "|]" "[|" "|}" "{|" "[< >]" "|>" "<|" "||>" "<||" "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::=" ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__"
  set confusions "iLloO0"
  echo -n "numbers: "
    for i in $nums
      echo -ne "$i "
        if test $is_instant -eq 1 
          sleep .2
        end
  end
  echo \n
  echo -n "letters: "
    for i in $alps
      echo -ne "$i "
      if test $is_instant -eq 1 
        sleep .2
      end
  end
  echo \n
  echo -n "symbols: "
    for i in $punct
      echo -ne "$i "
      if test $is_instant -eq 1
        sleep .2
      end
    end
  echo \n
  echo -n "ligatures: "
    for i in $ligatures
      echo -ne "$i "
      if test $is_instant -eq 1
        sleep .2
      end
    end
  echo \n
  echo -n "commonly confused: "
  echo -ne "$confusions"
  switch $argv[1]
    case "unicode"
      echo \n
      curl https://www.cl.cam.ac.uk/~mgk25/ucs/Postscript.txt
  end
end

function nbx
	jupyter nbconvert --execute $argv[1] --to $argv[2]
end

function wttr
	switch $argv[1]
		case $argv[1]
			curl wttr.in/$argv[1]
		case "*"
			curl wttr.in/gudivada
	end
end

function enc
	age -p -o $argv[2] $argv[1]
end

function dec
	age -d $argv[1]
end

function extract --description "Expand or extract bundled & compressed files"
    set argLen (count $argv)

    if test $argLen -lt 1
        echo "no archive name given"
        exit 1
    end

    if test -e $argv[1]
        set ext (echo $argv[1] | awk -F. '{print $NF}')
        switch $ext
            case tar.xz
                tar -xvf "$argv[1]"
            case tar.bz2
                tar -jxvf "$argv[1]"
            case tar.gz
                tar -zxvf "$argv[1]"
            case bz2
                bunzip2 "$argv[1]"
            case dmg
                hdiutil mount "$argv[1]"
            case gz
                gunzip "$argv[1]"
            case tar
                tar -xvf "$argv[1]"
            case tbz2
                tar -jxvf "$argv[1]"
            case tgz
                tar -zxvf "$argv[1]"
            case zip
                unzip "$argv[1]"
            case pax
                cat "$1" | pax -r
            case pax.z
                uncompress "$1" --stdout | pax -r
            case rar 7z
                7z x "$argv[1]"
            case z
                uncompress "$argv[1]"
            case *
                echo "'$argv[1]' cannot be extracted/mounted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end
