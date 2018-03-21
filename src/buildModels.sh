#!/bin/bash

outputsTrainPath=src/classification/train/outputs

rm -r $outputsTrainPath/models
mkdir $outputsTrainPath/models

for svmFile in $outputsTrainPath/svms/*.svm; do
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
  done < $svmFile

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

  fullfFileName=$(basename "$svmFile")
  fileName="${fullfFileName%.*}"

  modelFile=$outputsTrainPath/models/$fileName.model
  lib/libsvm/svm-train -w+1 $weight -b 1 -g 1 $svmFile $modelFile

  echo $modelFile is generated.
done
