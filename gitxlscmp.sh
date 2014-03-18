#!/bin/bash

FN=`basename "$1"`
TMPFILE=`mktemp -t gitxlscmp."${FN}"` || exit 1
git show HEAD:"$1" > "$TMPFILE"
open -a "Microsoft Excel" "$TMPFILE" "$1" 

# Want to delete $TMPFILE once open in Excel,
# but $(open) returns immediately, so check for ourselves
until lsof -a -c "Microsoft Excel" "$TMPFILE" > /dev/null; do
	sleep 0.5
done
rm "$TMPFILE"
