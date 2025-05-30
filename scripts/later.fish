#!/usr/bin/env fish

argparse 'a/add=+' 'r/remove' 'h/help' -- $argv

set cat "/bin/cat"
set storage_folder ~/Documents/scripts/helpers
set storage later_links.txt

function help
    echo -e "Save urls for later reads(requires fzf + rg), tab to multi-select."
    echo -e "Usage:"
    echo -e "\tlater -a <URL>: add url"
    echo -e "\tlater -r: remove url"
end

function open_link
    open $argv[1]
end

function remove_links
    set selected ($cat $storage_folder/$storage | fzf -m --cycle --wrap --tac)

    if test (count $selected) -eq 0
        echo "No links selected to remove."
        return 0
    end

    set tmp (mktemp)

    for link in ($cat $storage_folder/$storage)
        if not contains $link $selected
            echo $link >> $tmp
        else
            echo "Removed $link"
        end
    end

    mv $tmp $storage_folder/$storage
end

function duplicate
    $cat $storage_folder/$storage | rg -q "^$argv[1]"
end

function save_link
    set url $argv[1]

    if not test -e $storage_folder/$storage
        mkdir -p $storage_folder
        touch $storage_folder/$storage
    end

    if duplicate $url
        echo "skipped '$url' as it's a duplicate!"
        return 0
    end
    echo $url >> $storage_folder/$storage
    echo "added $url"
end


# --- exec ---

if set -q _flag_help
    help
    return 0
end

if set -q _flag_add
    for link in $_flag_add
        save_link $link
    end
    return 0
end

if not test -e "$storage_folder/$storage"; or test (count ($cat $storage_folder/$storage)) -eq 0
    echo "No links!"
    return 0
end

if set -q _flag_remove
    remove_links
    return 0
end

set links_to_open ($cat $storage_folder/$storage | fzf -m --cycle --wrap --tac)
if test -n "$links_to_open"
    for link in $links_to_open
        open_link $link
    end
else
    echo "Nothing selected!"
    return 0
end
