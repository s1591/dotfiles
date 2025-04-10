function log
    printf "%s - %s\n" (date) $argv[1]
end

# see set_color -c for named colors
function printIn
    set_color $argv[1]
    printf "%s" $argv[2]
    set_color normal
end
