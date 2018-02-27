#!/bin/bash
resultFile=results
label=$1
execFile=src/script_one/buildPerfOneModel.sh
opt="-w+1 19 -g "
#echo "" > $resultFile
for i in `seq 5 9`;
do
	bash $execFile $label $opt 0.2$i| grep "^0" >> $resultFile
	echo "execution $i termine"
done

