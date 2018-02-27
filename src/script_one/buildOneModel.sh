#!/bin/bash

output_train_path=src/classification/train/outputs
label=$1
opt=`echo "${@:2}"`

modelPath=$output_train_path/models/colors_$label.model
filePath=$output_train_path/svms/colors_$label.svm
lib/libsvm/svm-train -q -b 1 $opt $filePath $modelPath
