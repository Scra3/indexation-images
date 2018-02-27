#!/bin/bash
label=$1
opt=`echo "${@:2}"`
apFile=src/classification/val/outputs/aps/$1.ap

# echo $opt
make build_one_model label=$label opt="$opt"

perfLine=`echo $(cat $apFile | grep "^map")`
IFS=' ' read -r -a array <<< $perfLine
echo ${array[2]} $opt