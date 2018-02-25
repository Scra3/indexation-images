#! /bin/bash

topsDirectory=src/classification/val/outputs/tops

rm -r $topsDirectory
mkdir $topsDirectory

for annFile in src/classification/val/annotations/*.ann; do
  fullfFileName=$(basename "$annFile")
  label="${fullfFileName%.*}"

  topFile=$topsDirectory/colors_$label.top
  outFile=src/classification/val/outputs/outs/colors_$label.out

  IFS=$'\n' read -d '' -r -a annContent < $annFile
  IFS=$'\n' read -d '' -r -a outContent < $outFile

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
  echo colors_$label.out is formated and sorted to top format.
done
