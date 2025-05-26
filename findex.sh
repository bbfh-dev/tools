#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file-with-paths>"
    exit 1
fi

filelist=$1

if [ ! -f $filelist ]; then
    echo "Error: '$filelist' not found."
    exit 1
fi

index=1

# Read each line (path) from the list
while IFS= read -r filepath; do
    # Skip empty lines
    [ -z "$filepath" ] && continue

    filename=$(basename "$filepath")
    linkname="${index}-${filename}"

    # Create the symlink in the current directory
    ln -s "$filepath" "$linkname"
    echo "Created symlink: $linkname -> $filepath"

    index=$(( index + 1 ))
done < "$filelist"

