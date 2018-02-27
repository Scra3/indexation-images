#!/bin/bash

resultFile=src/app/results.txt

rm $resultFile
touch $resultFile

for outFile in src/app/outs/*.out; do
  fullfFileName=$(basename "$outFile")
  fileName="${fullfFileName%.*}"

  IFS=$'\n' read -d '' -r -a outContent < $outFile
  outLine=${outContent[1]}

  IFS=' ' read -r -a array <<< $outLine
  score="${array[1]}"

  IFS='_' read -r -a array <<< $fileName
  label=${array[1]}

  echo $score $label >> $resultFile
done

sort -r $resultFile -o $resultFile

echo "--------------------------------------"
cat $resultFile
echo "--------------------------------------"
