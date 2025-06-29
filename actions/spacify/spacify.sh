#!/usr/bin/env bash

replace_with_spaces() {
    for file in "$@"; do

        if [[ -f "$file" ]]; then # Only spacify files. Not directories

            # Get the filename without the prepended path (anything after the right-most '/')
            filename_with_extension=${file##*/}

            if [[ "$filename_with_extension" == *"."* ]]; then # If filename contains a '.'

                # Get the filename extension (anything after the right-most '.')
                extension=".${filename_with_extension##*.}"

                # Get the filename without the extension (anything before the right-most '.')
                filename_without_extension=${filename_with_extension%.*}

            else
                extension=""
                filename_without_extension="$filename_with_extension"
            fi

            # Replace hyphens and underscores with spaces
            new_filename="${filename_without_extension//-/ }"
            new_filename="${new_filename//_/ }"

            # Rename the file
            mv "$file" "${parent_directory}/${new_filename}${extension}"
        fi
    done
}


# Obtain the first argument and remove it from the argument array
parent_directory="$1"
shift

replace_with_spaces "$@"