rm src/classification/val/colors_all.top
touch src/classification/val/colors_all.top
cat src/classification/val/outputs/tops/*.top >> src/classification/val/colors_all.top
lib/trec_eval.9.0/trec_eval $1 $2 > src/classification/val/all.out
