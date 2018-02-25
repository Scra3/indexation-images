#!/bin/bash

val_colors=$1
outputs_val_path=$2

rm -r $outputs_val_path
mkdir $outputs_val_path

for model_path in src/classification/train/outputs/models/*.model; do
  fullfFileName=$(basename "$model_path")
  fileName="${fullfFileName%.*}"

  lib/libsvm/svm-predict -b 1 $val_colors $model_path $outputs_val_path/$fileName.out
done
