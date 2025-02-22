#!/bin/bash
#traversing the file system from a given directory, including subdirectories

if [ $# -ne 2 ]; then
	echo "Usage <no_files> <max_size>"
	exit 1;
fi

direct=$1
number=$2
size=$3

# shows the n smallest files within a size specified by the user.
echo -e "Files founds:\n"
find "$direct" -type f -size "-${size}c" 2>/dev/null | head -n "$number"
