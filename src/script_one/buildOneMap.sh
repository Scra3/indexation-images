#!/bin/bash

label=$1
valPath=src/classification/val
relFile=$valPath/rels/$label.rel
apFile=$valPath/outputs/aps/$label.ap
topFile=$valPath/outputs/tops/colors_$label.top

rm $apFile
touch $apFile
lib/trec_eval.9.0/trec_eval $relFile $topFile > $apFile

#echo $apFile is build
