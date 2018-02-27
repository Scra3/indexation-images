#!/bin/bash
label=$1
val_path=src/classification/val
top_path=$val_path/outputs/tops
out_path=$val_path/outputs/outs
ann_path=$val_path/annotations

topFile=$top_path/colors_$1.top
outFile=$out_path/$1.out
annFile=$ann_path/$1.ann

IFS=$'\n' read -d '' -r -a annContent < $annFile
IFS=$'\n' read -d '' -r -a outContent < $outFile

rm -rf $topFile
touch $topFile

for index in ${!annContent[*]}; do
    annLine=${annContent[index]}
    imageId=${annLine:0:11}

    IFS=' ' read -r -a outElements <<< ${outContent[$(($index+1))]}
    score="${outElements[1]}"

    echo $"${label} Q0 ${imageId} 0 ${score} R" >> $topFile
done


nbCharslabel=$(echo "$label" | wc -c)
nbCharsImageId=11
# -1 because end of string
nbOfChars=$((7 + $nbCharslabel-1 + $nbCharsImageId))

sort -r -k1."$nbOfChars" "$topFile" -o "$topFile"
#echo colors_$label.out is formated and sorted to top format.
