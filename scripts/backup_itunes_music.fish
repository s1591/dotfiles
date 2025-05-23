#!/usr/bin/env fish

argparse 'd/delete-source' -- $argv

set source_dir ~/Music/Music/Media.localized/Music
set backup_directory ~/Music/purchased_backups

set copied_count 0

function log
    printf "%s - %s\n" (date) $argv[1]
end

function move_source_to_trash
    mv $source_dir ~/.Trash
    if test $status -eq 0
        log "Moved '$source_dir' to Trash."
        return 0
    else
        return 1
    end
end

if set -q _flag_d
    return (move_source_to_trash)
end

function check_for
    argparse 's/source-dir' 't/tracks' -- $argv

    if set -q _flag_s
        if not test -d $source_dir
            log "Source directory '$source_dir' doesn't exist."
            exit 1
        end
    end

    if set -q _flag_tracks
        if test (count $tracks) -eq 0
            log "Nothing to backup."
            exit 1
        end
    end
end

function move_tracks
    for track in $tracks
        cp $source_dir/$track $backup_directory
        log "Copied $track"
        set copied_count (math $copied_count + 1)
    end
end

# --- exec ---

check_for --source-dir

set tracks (fd -e m4a --base-directory $source_dir)

check_for --tracks

mkdir -p $backup_directory

move_tracks

echo -e "\nFinished backup($copied_count track[s])."
