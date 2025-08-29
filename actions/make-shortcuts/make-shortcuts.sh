#!/usr/bin/env bash

fallback_directory_icon="inode-directory"

create_symlinks() {
    for item in "$@"; do

        # Make a fake symlink for folders and real symlinks for anything else
        if [[ -d "$item" ]]; then

            file_extension=".desktop"

            if get_unique_filename; then
                make_fake_symlink
            fi
        else
            file_extension=""

            if get_unique_filename; then
                make_regular_symlink
            fi
        fi
    done
}


make_fake_symlink() {

    obtain_icon "$item"

    echo -e "[Desktop Entry]\nName="$symlink_name"\nComment=\nExec=nemo --existing-window \"${item}\"\nType=Application\nIcon=$icon" > "${parent_directory}/${symlink_name}.desktop"
    add_emblem
    make_executable
}


make_regular_symlink() {
    ln -s "$item" "${parent_directory}/${symlink_name}"
}


get_unique_filename() {

    if [[ "$file_extension" == ".desktop" ]]; then
        type="Shortcut"
    else
        type="Link"
    fi

    # Get folder/file name without prepended path
    selected_file=${item##*/}

    max_duplicate_symlinks=5
    symlink_name_candidate="${type} to ${selected_file}"

    for ((i=2; i <= max_duplicate_symlinks+1; i++)); do

        # If filename is unique, use it
        if ! [[ -e "${parent_directory}/${symlink_name_candidate}${file_extension}" ]]; then

            symlink_name="$symlink_name_candidate"
            return 0

        else # Add a number to the filename, starting from 2
            symlink_name_candidate="${type} ${i} to ${selected_file}"
        fi
    done

    error_message "The maximimum amount of identical shortcuts/symlinks in a single directory to \"$selected_file\" that the script allows is ${max_duplicate_symlinks}."
    return 1
}


obtain_icon() {
    icon=""

    # Look for custom folder icon
    icon=$(gio info "$1" | awk '/metadata::custom-icon-name:/ { print $2 }')

    if [[ -z "$icon" ]]; then
        # Look for primary standard icon
        icon=$(gio info "$1" | awk '/standard::icon:/ { gsub(/,/, "", $2); print $2 }')

        # If icon is still not set
        if [[ -z "$icon" ]]; then
            icon="$fallback_directory_icon"
        fi
    fi
}


add_emblem() {
    gio set -t stringv "${parent_directory}/${symlink_name}.desktop" metadata::emblems emblem-link && touch "${parent_directory}/${symlink_name}.desktop"
}


make_executable() {
    chmod +x "${parent_directory}/${symlink_name}.desktop"
}


error_message() {
    echo "$(date "+%D %r"): $1" >> "${parent_directory}/Script error message.txt"
}

# Obtain the first argument and remove it from the argument array
parent_directory="$1"
shift

create_symlinks "$@"