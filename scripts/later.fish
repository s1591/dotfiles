#!/usr/bin/env fish

argparse 'a/add=+' 'r/remove' -- $argv

set cat "/bin/cat"
set storage ~/Documents/scripts/helpers/later_links.txt


function open_link
    open $argv[1]
end

function remove_links
    set selected ($cat $storage | fzf -m --cycle --wrap --tac)

    if test (count $selected) -eq 0
        echo "No links selected to remove."
        return 0
    end

    set tmp (mktemp)

    for link in ($cat $storage)
        for needs_to_remove in $selected
            if test $needs_to_remove != $link
                echo $link >> $tmp
            end
        end
    end

    mv $tmp $storage
end

function duplicate
    $cat $storage | rg -q "^$argv[1]"
end

function save_link
    set url $argv[1]

    if not test -e $storage
        touch $storage
    end

    if duplicate $url
        echo "skipped '$url' as it's a duplicate!"
        return 0
    end
    echo $url >> $storage
end


# --- exec ---

if set -q _flag_add
    for link in $_flag_add
        save_link $link
    end
    return 0
end

if not test -e "$storage"; or test (count ($cat $storage)) -eq 0
    echo "No links!"
    return 0
end

if set -q _flag_remove
    remove_links
    return 0
end

set links_to_open ($cat $storage | fzf -m --cycle --wrap --tac)
if test -n "$links_to_open"
    for link in $links_to_open
        open_link $link
    end
else
    echo "Nothing selected!"
    return 0
end
