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

function makebak
    cp $argv[1] $argv[1].bak
end

function available
    command -v $argv[1] > /dev/null
end

function d --description "jump to a directory quickly using fzf or television"

    if not available fd
        echo "fd not available"
        return 1
    end

    set currDir $PWD
    set fd_for_directory "fd . --type d --max-depth 4"
    set fd_for_hidden_directory "fd . --type d -H --max-depth 4"

    if available tv
        set fuzzy_finder_for_directory 'tv --preview "eza -a --icons=always --color=always {}"'
    else if available fzf
        set fuzzy_finder_for_directory 'fzf --prompt="\$" --pointer="*" --preview "ls {}"'
    else
        echo "fzf or television not found"
        return 1
    end

    switch $argv[1]
        case h
            set fuzzy_finder (echo "$fd_for_hidden_directory | $fuzzy_finder_for_directory")
        case "*"
            set fuzzy_finder (echo "$fd_for_directory | $fuzzy_finder_for_directory")
    end

    set dest (eval $fuzzy_finder)
    if test $status -eq 0 && test $dest # exit status = 0 & dest should not be empty
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
    printIn red "numbers: "
    for i in $nums
        echo -ne "$i "
        if test $is_instant -eq 1
            sleep .2
        end
    end
    echo \n
    printIn red "letters: "
    for i in $alps
        echo -ne "$i "
        if test $is_instant -eq 1
            sleep .2
        end
    end
    echo \n
    printIn red "symbols: "
    for i in $punct
        echo -ne "$i "
        if test $is_instant -eq 1
            sleep .2
        end
    end
    echo \n
    printIn red "ligatures: "
    for i in $ligatures
        echo -ne "$i "
        if test $is_instant -eq 1
            sleep .2
        end
    end
    echo \n
    printIn red "commonly confused: "
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
                             [-h | --help for help]"

    argparse 'h/help' 'c/cmd' 's/system' -- $argv

    if set -q _flag_help
        printf "Usage of alert:\n\talert (msg) (title) (opts)"
        printf "\n\t[-c | --cmd]\n\t\tprints the command used to send alert and exit"
        echo -e "\n\t[-s | --system]\n\t\tcreate the alert using 'System Events'"
        return 0
    end

    if set -q _flag_system
        set cmd (printf "osascript -e 'tell app \"System Events\" to display alert \"%s\" message \"%s\"'" \
        "$argv[2]" "$argv[1]")
    else
        set cmd (printf "osascript -e 'tell app \"Ghostty\" to display alert \"%s\" message \"%s\"'" \
        "$argv[2]" "$argv[1]")
    end

    if set -q _flag_cmd
        echo $cmd
        return 0
    end

    eval $cmd > /dev/null

end

function printIn --description "printIn [-h | --help]"

    argparse 'h/help' 'c/cmd' 'w/with=' -- $argv

    if test (count $argv) -lt 2 || set -q _flag_help
        printf "printIn uses set_color to print colored stuff:"
        printf "\n\tprintIn color message (opts)"
        printf "\n\t[-w | --with]"
        printf "\n\t\td: dim, o: bold, i: italics, u: underline, r: reverse mode, b<COLOR>: background color"
        printf "\n\t[-c | --cmd]"
        printf "\n\t\tprint the equivalent set_color command and exit"
        printf "\n\t[-h | --help]"
        printf "\n\t\tdisplay this and exit"
        printf "\n\nexamples:"
        printf "\n\tprintIn red red => %s" \
            (printIn red red)
        printf "\n\tprintIn red red -w '%s' => %s" \
            "r" (printIn red red -w 'r')
        printf "\n\tprintIn red '%s' -w '%s' => %s" \
            "BOLD + UNDERLINE" "ou" (printIn red 'BOLD + UNDERLINE' -w 'ou')
        printf "\n\tprintIn black hihihihi -w 'oubblue' => %s" \
            (printIn black hihihihi -w 'oubblue')
        printf "\n\tprintIn 000 'fishing' -w 'ub928' => %s" \
            (printIn 000 'fishing' -w 'ub928')
        printf "\n\tprintIn red 'BOLD + UNDERLINE' -w 'ou' -c => %s" \
            (printIn red 'BOLD + UNDERLINE' -w 'ou' -c)
        printf "\n\t%s: b<COLOR> should always come at end since whatever is after b is interpreted as a color" \
            (printIn red note -w 'u')
        echo -e "\n\nSee: https://fishshell.com/docs/current/cmds/set_color.html"
        return 0
    end

    if set -q _flag_cmd
        if set -q _flag_with
            set cmd (printf "set_color -$_flag_with $argv[1]; echo \"$argv[2]\"; set_color normal")
        else
            set cmd (printf "set_color $argv[1]; echo \"$argv[2]\"; set_color normal")
        end
        echo $cmd
        return 0
    end

    if set -q _flag_with
        set_color -$_flag_with $argv[1]
    else
        set_color $argv[1]
    end

    if test $status -ne 0
        return 1
    end

    printf $argv[2]

    set_color normal

end
