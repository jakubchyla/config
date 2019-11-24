#! /bin/bash

cd backup
for file in `find . -type f`; do
    src_file=`echo $file | sed "s#.#$HOME#"`
    dest_file=`readlink -f $file`
    cp $src_file $dest_file 2>/dev/null
done
