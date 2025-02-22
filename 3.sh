#!/bin/bash
# Traversing the file system from a given directory, including subdirectories

if [ $# -ne 3 ]; then
    echo "Usage: <directory> <number_of_files> <max_size>"
    exit 1
fi

direct=$1
number=$2
size=$3

# Show the n smallest files within a size specified by the user.
echo -e "Files found:\n"

# Find all files, get their sizes and names, then sort by size and show the smallest ones
find "$direct" -type f -size "-${size}c" 2>/dev/null | while read file; do
    # Using stat to get the size and name of the file (adjusted for Slackware, using GNU stat)
    stat --format="%s %n" "$file"
done | sort -n -k1 | head -n "$number" | awk '{print $1, $2}'
