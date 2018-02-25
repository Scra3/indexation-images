build_app:
	gcc lib/rdjpeg.c lib/svm_format.c src/app/main.c src/app/tri_histo.c -o bin/tri_histo -w

run_app:
	bin/tri_histo $(urls_file)

clean:
	rm -f bin/tri_histo

build_all_train: build_train_colors add_ann_to_train_colors build_train_models

build_train_colors:
	bash src/buildVectorsHistos.sh src/classification/train/urls.txt src/classification/train/outputs/train_colors.svm

add_ann_to_train_colors:
	bash src/addAnnToVectorsHistos.sh train

build_train_models:
	bash src/buildModels.sh

build_all_val: build_val_colors build_val_prediction converter_out_to_top_format build_map

build_val_colors:
	bash src/buildVectorsHistos.sh src/classification/val/urls.txt src/classification/val/outputs/val_colors.svm

build_val_prediction:
	bash src/buildPredictions.sh src/classification/val/outputs/val_colors.svm src/classification/val/outputs/outs

converter_out_to_top_format:
	bash src/converterOutsToTops.sh

build_map:
	bash src/buildMeanAveragePrecision.sh

picture_classification: build_app
	echo $(url) > src/test/url.txt
	bash src/buildVectorsHistos.sh src/test/url.txt src/test/val_colors.svm
	bash src/buildPredictions.sh src/test/val_colors.svm src/test/outs
	bash src/test/sortClassification.sh
