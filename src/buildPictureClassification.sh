echo $1 > src/app/url.txt
bash src/buildVectorsHistos.sh src/app/url.txt src/app/val_colors.svm
bash src/buildPredictions.sh src/app/val_colors.svm src/app/outs
bash src/app/sortClassification.sh
