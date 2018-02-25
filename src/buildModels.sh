#!/bin/bash

outputs_train_path=src/classification/train/outputs

rm -r $outputs_train_path/models
mkdir $outputs_train_path/models

for filePath in $train_path/outputs/svms/*.svm; do
  weight=0
  nbPositive=0
  nbNegative=0

  while read line
  do
    label=${line%% *}
    if [ $label = "-1" ]
    then
      nbNegative=$(($nbNegative+1))
    else
      nbPositive=$(($nbPositive+1))
    fi
  done < $filePath

  if [ $nbPositive = "0" ]
  then
    ## Default weight
    weight=19
  else
    weight=$(($nbNegative/$nbPositive))
    echo $nbNegative
    echo $nbPositive
  fi

  echo "Weight is: "$weight

  fullfFileName=$(basename "$filePath")
  fileName="${fullfFileName%.*}"

  modelPath=$outputs_train_path/outputs/models/$fileName.model
  lib/libsvm/svm-train -w+1 $weight -b 1 -g 1 $filePath $modelPath
done
