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
    # command -v $argv[1] > /dev/null
    type -q $argv[1]
    return $status
end

function d --description "jump to a directory/file quickly using fzf or television
                         [-h for help]"

    # alternatively https://github.com/alexpasmantier/television/blob/main/docs/channels.md, which is much easier.
    # cd (tv dirs), tv custom_channel...
    # this function exists to not to be dependent on configuration of tv or fzf

    argparse 'h/help' 'f/files' 'c/cmd' -- $argv

    if set -q _flag_help
        printf "Usage of d:"
        printf "\n\td (opts)"
        printf "\n\t[h or .]:"
        printf "\n\t\tinclude hidden directories(or files if -f is used)"
        printf "\n\t[-f | --files]"
        printf "\n\t\tinclude only files"
        printf "\n\t[-c | --cmd]"
        printf "\n\t\tprint the command used and exit"
        printf "\n\t[-h | --help]"
        echo -e "\n\t\tshow this and exit"
        return 0
    end

    if not available fd; and not available tv; or not available fzf
        echo "make sure to have fd, tv/fzf"
        return 1
    end

    set currDir $PWD
    set fd_for_directory "fd . --type d --max-depth 4"
    set fd_for_hidden_directory "fd . --type d -H --max-depth 4"
    set fd_for_files "fd . --type f --max-depth 4"
    set fd_for_hidden_files "fd . --type f -H --max-depth 4"

    if available tv
        if set -q _flag_files
            set fuzzy_finder_for_files 'tv --preview "bat --color=always --style=numbers --line-range=:500 {}"'
        else
            set fuzzy_finder_for_directory 'tv --preview "eza -a --icons=always --color=always {}"'
        end
    else
        if set -q _flag_files
            set fuzzy_finder_for_files 'fzf --prompt="\$ " --pointer="*" --preview "bat --color=always --style=numbers --line-range=:500 {}"'
        else
            set fuzzy_finder_for_directory 'fzf --prompt="\$" --pointer="*" --preview "ls {}"'
        end
    end

    switch $argv[1]
        case h .
            if set -q _flag_files
                set fuzzy_finder (echo "$fd_for_hidden_files | $fuzzy_finder_for_files")
            else
                set fuzzy_finder (echo "$fd_for_hidden_directory | $fuzzy_finder_for_directory")
            end
        case "*"
            if set -q _flag_files
                set fuzzy_finder (echo "$fd_for_files | $fuzzy_finder_for_files")
            else
                set fuzzy_finder (echo "$fd_for_directory | $fuzzy_finder_for_directory")
            end
    end

    if set -q _flag_cmd
        echo $fuzzy_finder
        return 0
    end

    set dest (eval $fuzzy_finder)
    if test $status -eq 0 && test $dest # exit status = 0(for fzf) & dest should not be empty(for tv)
        if set -q _flag_files
            $EDITOR $dest
        else
            cd $dest
        end
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
    set confusions ilLoO0
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
        echo -e "printIn uses set_color to print colored text with optional formatting:\n"
        echo -e "Usage:\n"
        echo -e "\tprintIn <color> <message> [options]\n"
        echo -e "Options:\n"
        echo -e "\t-w, --with <format>\tApply text formatting (dim: d, bold: o, italics: i, underline: u, reverse: r, background: b)\n"
        echo -e "\t-c, --cmd\t\tPrint the equivalent set_color command\n"
        echo -e "\t-h, --help\t\tDisplay this help message\n"
        echo -e "\nExamples:\n"
        echo -e "\tprintIn red 'Hello, World!'\n"
        echo -e "\tprintIn red 'Bold and Underlined' -w 'ou'\n"
        echo -e "\tprintIn black 'Background color' -w 'ub928'\n"
        echo -e "\nsee: https://fishshell.com/docs/current/cmds/set_color.html"
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

    echo $argv[2]

    set_color normal
end
