#!/usr/bin/env bats

@test "build an histogramme" {
  expectedHisto="0 1:0.219620 2:0.012362 3:0.000692 5:0.011878 6:0.016588 7:0.001833 11:0.000054 17:0.000633 18:0.000090 21:0.008882 22:0.102557 23:0.016199 24:0.000009 26:0.001367 27:0.039000 28:0.000009 37:0.000186 38:0.002652 39:0.000222 41:0.000005 42:0.003778 43:0.231674 44:0.015805 47:0.000353 48:0.007032 59:0.000986 60:0.000100 63:0.000457 64:0.304977"
  histo=$(bin/tri_histo "http://mrim.imag.fr/voc10/images/2008_000008.jpg")
  [ "$histo" == "$expectedHisto" ]
}

@test "All train svm files is annoted" {
  svms_train=src/classification/train/outputs/svms/colors_aeroplane.svm

  while read line
  do
    IFS=' ' read -r -a label <<< $line

    [ "$label" -ne "0" ]
  done < $svms_train
}
