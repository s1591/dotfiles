function log
    printf "%s - %s\n" (date) $argv[1]
end

function printIn
    set_color $argv[1]
    printf "%s" $argv[2]
    set_color normal
end
