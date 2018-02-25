#!/bin/bash

val_colors=$1
output=$2

outputs_val_path=src/classification/val/outputs

rm -r $outputs_val_path/outs
mkdir $outputs_val_path/outs

for model_path in src/classification/train/outputs/models/*.model; do
  fullfFileName=$(basename "$model_path")
  fileName="${fullfFileName%.*}"

  lib/libsvm/svm-predict -b 1 $val_colors $model_path $output/$fileName.out
done
