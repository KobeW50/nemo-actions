#!/usr/bin/env bash

working_directory="$1"
shift

# Ensure working directory exists (ie: not recents, trash, search results, etc.)
if [[ -z "$working_directory" ]]; then
    # Exit with err. code 1, so that Nemo action won't be shown
    exit 1
fi

for file in "$@"; do

    # Get the filename without the prepended path (anything after the right-most '/')
    filename_with_extension=${file##*/}

    # Get the filename without the extension (anything before the right-most '.')
    filename_without_extension=${filename_with_extension%.*}

    # If a selected file contains spaces or underscores
    if [[ -f "$file" && ("$filename_without_extension" == *" "* || "$filename_without_extension" == *"_"*) ]]; then
        exit 0
    fi
done

# Don't show the Nemo action if none of the selected files have a space or underscore
exit 1