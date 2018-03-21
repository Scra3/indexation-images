#!/bin/bash
label=$1
resultFile=results/$1_results
execFile=src/script_one/buildPerfOneModel.sh
opt="-w+1 3 -g"
#echo "" > $resultFile
for i in `seq 1 9`:
do
	bash $execFile $label $opt 0.$i| grep "^0" >> $resultFile
	echo "execution $i termine"
done

