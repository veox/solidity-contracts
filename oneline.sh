#!/usr/bin/sh
# turn contract into a one-liner and copy to clipboard (if possible)

hash=`echo $* | md5sum | cut -c'-8'`
tempfile="/tmp/oneline-$hash"

cat $* | sed 's@//.*@@g;s@/\*.*\*/@@g' | tr '\n' ' ' | tr -s ' ' > $tempfile

if [ "x`command -v xclip`" != "x" ]; then
    xclip -selection primary < $tempfile
    echo "Copied to clipboard."
else
    echo "" >> $tempfile
    cat $tempfile
fi

rm $tempfile

