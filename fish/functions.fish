function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
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
    command -v $argv[1] >/dev/null
end

function o --description "open a file quickly using fzf"
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
        case h
            set dest (fd . --type d -H --max-depth 4 | fzf --prompt="\$ " --pointer="*" --preview 'ls {}')
        case "*"
            set dest (fd . --type d --max-depth 4 | fzf --prompt="\$ " --pointer="*" --preview 'ls {}')
    end
    if test $status -eq 0
        cd $dest
    else
        cd $currDir
    end
end

function test_letters --description "see how current font displays numbers, letters and some ligatures
                                    (arg1: a for .2s sleep between symbols or i for instant display,
                                    default: i)"
    switch $argv[1]
        case a
            set is_instant 1
        case "*"
            set is_instant 0
    end
    set nums (seq 0 9)
    set alps a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
    set punct "!" "@" "#" "\$" "%" "^" "&" "*" "(" ")" "{" "}"
    set ligatures -- --- "==" "===" "!=" "!==" "=!=" "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!" "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>" "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####" "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<\$>" "<\$" "\$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--" "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>" "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|" "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~" "~@" "[||]" "|]" "[|" "|}" "{|" "[< >]" "|>" "<|" "||>" "<||" "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::=" ":?" ":?>" // /// "/*" "*/" "/=" "//=" "/==" "@_" __
    set confusions iLloO0
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
end

function wttr --description "Display weather using wttr.in.
                            (arg1: city, default: gudivada)"
    switch $argv[1]
        case $argv[1]
            curl wttr.in/$argv[1]
        case "*"
            curl wttr.in/gudivada
    end
end

function alert --description "Display an alert using osascript
                             (-h | --help for help)"

    argparse 'h/help' 'c/cmd' -- $argv

    if set -q _flag_help
        printf "Usage of alert:\n\talert [msg] [title]"
        printf "\n\t[-c | --cmd]:\n\t\tprints the command used to send alert"
        return 0
    end

    # appears on current space
    # set cmd (printf "osascript -e 'tell app \"System Events\" to display dialog \"%s\" with title \"%s\"'" \
        # "$argv[1]" "$argv[2]")

    # appears on terminals space
    set cmd (printf "osascript -e 'tell app \"Ghostty\" to display alert \"%s\" message \"%s\"'" \
        "$argv[2]" "$argv[1]")

    if set -q _flag_cmd
        echo $cmd
        return 0
    end

    eval $cmd > /dev/null

end

#function extract --description "Expand or extract bundled & compressed files"
#    set argLen (count $argv)
#
#    if test $argLen -lt 1
#        echo "no archive name given"
#        return 1
#    end
#
#    if test -e $argv[1]
#        set ext (echo $argv[1] | awk -F. '{print $NF}')
#        switch $ext
#            case tar.xz
#                tar -xvf "$argv[1]"
#            case tar.bz2
#                tar -jxvf "$argv[1]"
#            case tar.gz
#                tar -zxvf "$argv[1]"
#            case bz2
#                bunzip2 "$argv[1]"
#            case dmg
#                hdiutil mount "$argv[1]"
#            case gz
#                gunzip "$argv[1]"
#            case tar
#                tar -xvf "$argv[1]"
#            case tbz2
#                tar -jxvf "$argv[1]"
#            case tgz
#                tar -zxvf "$argv[1]"
#            case zip
#                unzip "$argv[1]"
#            case pax
#                cat "$1" | pax -r
#            case pax.z
#                uncompress "$1" --stdout | pax -r
#            case rar 7z
#                7z x "$argv[1]"
#            case z
#                uncompress "$argv[1]"
#            case *
#                echo "'$argv[1]' cannot be extracted/mounted via extract()"
#        end
#    else
#        echo "'$argv[1]' is not a valid file"
#    end
#end
