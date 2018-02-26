#!/bin/bash

label=$1
model_path=src/classification/train/outputs/models/colors_$label.model
val_path=src/classification/val
val_colors=$val_path/outputs/val_colors.svm
output_path=$val_path/outputs/outs/$label.out

#echo $val_colors
#echo $model_path
#echo $out
lib/libsvm/svm-predict -b 1 $val_colors $model_path $output_path

