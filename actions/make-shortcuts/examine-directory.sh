#!/usr/bin/env bash

working_directory="$1"

# Ensure working directory exists (ie: not recents, trash, search results, etc.)
if [[ -z "$working_directory" ]]; then
    # Exit with err. code 1, so that Nemo action won't be shown
    exit 1
else
    exit 0
fi
