set okMark 󰄭
set xMark 
set errCount 0

function log

    if test $status -eq 0
        set mark (printIn green $okMark)
    else
        set mark (printIn red $xMark)
        set errCount (math $errCount + 1)
    end

    argparse 'n/nomark' -- $argv

    if set -q _flag_nomark
        printf "%s - %s\n" (date) $argv[1]
    else
        printf "%s - %s $mark\n" (date) $argv[1]
    end

end

# see set_color -c for named colors
function printIn
    set_color $argv[1]
    printf "%s" $argv[2]
    set_color normal
end
