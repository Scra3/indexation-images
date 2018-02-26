# Buil le générateur d'histogrammes
build_app:
	gcc lib/rdjpeg.c lib/svm_format.c src/app/main.c src/app/tri_histo.c -o bin/tri_histo -w

# Run le générateur d'histogrammes avec en params un fichier d'urls
run_app:
	bin/tri_histo $(urls_file)

clean:
	rm -f bin/tri_histo

build_all_train: build_train_colors add_ann_to_train_colors build_train_models

# Programme pour générer un fichier de vecteurs .svm "neutre" pour train
build_train_colors:
	bash src/buildVectorsHistos.sh src/classification/train/urls.txt src/classification/train/outputs/train_colors.svm

# Programme pour générer un fichier de vecteurs .svm avec annotations pour train
add_ann_to_train_colors:
	bash src/addAnnToVectorsHistos.sh train

# Application de svm-train
build_train_models:
	bash src/buildModels.sh

build_all_val: build_val_colors build_val_prediction converter_out_to_top_format build_map

# Programme pour générer un fichier de vecteurs .svm "neutre" pour val
build_val_colors:
	bash src/buildVectorsHistos.sh src/classification/val/urls.txt src/classification/val/outputs/val_colors.svm

# Application de svm-predict
build_val_prediction:
	bash src/buildPredictions.sh src/classification/val/outputs/val_colors.svm src/classification/val/outputs/outs

# Programme pour mise au format trec_eval
converter_out_to_top_format:
	bash src/converterOutsToTops.sh

# Evaluation avec trec_eval
build_map:
	bash src/buildMeanAveragePrecision.sh
	
build_one_model:
	bash src/script_one/buildOneModel.sh $(label) $(opt)
	bash src/script_one/buildOnePrediction.sh $(label)
	bash src/script_one/convertOneOutToTop.sh $(label)
	bash src/script_one/buildOneMap.sh $(label)

# TODO Evaluation de tous
# - all.rel, color_all.top -> MAP (performance color globale)

# Scrpt qui prend en entrée l'URL d'une image quelconque et qui
# fournit les scores de classification (probabilités)
# pour chacun des 20 concepts.

picture_classification: build_app
	echo $(url) > src/test/url.txt
	bash src/buildVectorsHistos.sh src/test/url.txt src/test/val_colors.svm
	bash src/buildPredictions.sh src/test/val_colors.svm src/test/outs
	bash src/test/sortClassification.sh
