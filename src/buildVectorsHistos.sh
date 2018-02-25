#! /bin/bash

urls=$1
path_train_colors=$2

rm $path_train_colors
touch $path_train_colors

while read url
do
  bin/tri_histo $url >> $path_train_colors
done < $urls
