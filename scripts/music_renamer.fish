#!/usr/bin/env fish

set cat "/bin/cat"
set track_data_file (mktemp)

set no_tags
set already_exists

function __save_track_info
    exiftool $argv[1] > $track_data_file
end

function __remove_track_info
    rm $track_data_file > /dev/null
    if test $status -ne 0
        echo "WARN: attempted to remove '$track_data_file' which doesn't exist!"
    end
end

function rename_track

    set artist
    set current_track $argv[1]

    # remove track number
    set removed_track_number ($cat $track_data_file | rg "Title" | choose -f ": " -1)

    # add artist name
    # Artist > Album Artist > Sort artist
    set artist (string trim ($cat $track_data_file | rg "^Artist\s{2,}" | choose -f ": " -1))
    if test -n "$artist"
        set final_track_name "$artist - $removed_track_number.m4a"
        if test -e "$final_track_name"
            set already_exists $already_exists $final_track_name
            return 1
        end
        mv $current_track $final_track_name
        echo "$current_track -> $final_track_name"
        return 0
    end

    set artist (string trim ($cat $track_data_file | rg "^Album Artist" | choose -f ": " -1))
    if test -n "$artist"
        set final_track_name "$artist - $removed_track_number.m4a"
        if test -e "$final_track_name"
            set already_exists $already_exists $final_track_name
            return 1
        end
        mv $current_track $final_track_name
        echo "$current_track -> $final_track_name"
        return 0
    end

    set artist (string trim ($cat $track_data_file | rg "^Sort Artist" | choose -f ": " -1))
    if test -n "$artist"
        set final_track_name "$artist - $removed_track_number.m4a"
        if test -e "$final_track_name"
            set already_exists $already_exists $final_track_name
            return 1
        end
        mv $current_track $final_track_name
        echo "$current_track -> $final_track_name"
        return 0
    end

    set no_tags $argv[1] $no_tags

    return 1

end

# --- exec ---

for track in (fd -e m4a)
    __save_track_info $track
    rename_track $track
    __remove_track_info
end

if test (count $no_tags) -ne 0
    echo -e "\n--- No valid artist tags for ---\n"
    for track in $no_tags
        echo $track
    end
end

if test (count $already_exists) -ne 0
    echo -e "\n--- Skipped as these already exist ---\n"
    for track in $already_exists
        echo $track
    end
end
