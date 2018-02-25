#! /bin/bash

apsRepository=src/classification/val/outputs/aps
mkdir $apsRepository

for fileTopPath in src/classification/val/outputs/tops/*.top; do
  fullfFileName=$(basename "$fileTopPath")
  fileName="${fullfFileName%.*}"

  IFS='_' read -r -a array <<< $fileName
  label="${array[1]}"

  relFile=src/classification/val/rels/$label.rel

  fileAp=$apsRepository/$label.ap

  rm $fileAp
  touch $fileAp

  lib/trec_eval.9.0/trec_eval $relFile $fileTopPath > $fileAp

  echo $fileAp is build
done
