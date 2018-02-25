#!/bin/bash

for filePath in src/classification/train/annotations/*.ann; do
  fullfFileName=$(basename "$filePath")
  fileName="${fullfFileName%.*}"

  svm_path=src/classification/$1/outputs/svms/colors_$fileName.svm

  rm $svm_path
  touch $svm_path

  while read annLine <&3 && read histoLine <&4;
  do
    label=${annLine##* }

    if [ $label -ne 0 ]
    then
      histoWithoutIndice=${histoLine:2}
      echo $label" "$histoWithoutIndice >> $svm_path
    fi
  done 3<$filePath 4<src/classification/train/outputs/train_colors.svm
done
