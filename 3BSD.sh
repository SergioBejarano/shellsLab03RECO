#!/bin/bash
#traversing the file system from a given directory, including subdirectories

if [ $# -ne 3 ]; then
	echo "Usage <directory> <no_files> <max_size>"
	exit 1;
fi

direct=$1
number=$2
size=$3

# shows the n smallest files within a size specified by the user.
echo -e "Files founds:\n"
find "$direct" -type f -size "-${size}c" 2>/dev/null | while read file; do
    stat -f "%z %N" "$file"
done | sort -n -k1 | head -n "$number" | awk '{print $1, $2}'
