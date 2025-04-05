function log
    printf "%s - %s\n" (date) $argv[1]
end

function printInRed
    set_color red
    printf "%s" $argv[1]
    set_color normal
end
