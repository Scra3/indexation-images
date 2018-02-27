echo $(url) > src/test/url.txt
bash src/buildVectorsHistos.sh src/test/url.txt src/test/val_colors.svm
bash src/buildPredictions.sh src/test/val_colors.svm src/test/outs
bash src/test/sortClassification.sh
