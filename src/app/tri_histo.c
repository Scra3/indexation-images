#include <stdlib.h>
#include <stdio.h>
#include "../../lib/rdjpeg.h"
#include "../../lib/svm_format.h"
#include "tri_histo.h"

#define BINS 4 // 64-bin
#define COLOR_RANGE_SIZE 256

static void tidyPixels(CIMAGE cim, int h[BINS][BINS][BINS]);
static void calculateProportion(
  CIMAGE cim,
  Array *svmFormat,
  int h[BINS][BINS][BINS]
);

void calculateTriHisto(CIMAGE cim, Array *svmFormat) {
  unsigned int h[BINS][BINS][BINS] = {{ 0 }};
  newSvnArray(svmFormat, 1, 0);

  tidyPixels(cim, h);
  calculateProportion(cim, svmFormat, h);
}

static void tidyPixels(CIMAGE cim, int h[BINS][BINS][BINS]) {
  unsigned char binRed, binGreen, binBlue;

  for (size_t i = 0; i < cim.nx; i++) {
    for (size_t j = 0; j < cim.ny; j++) {
      binRed = (unsigned int) (cim.r[i][j] * BINS) / COLOR_RANGE_SIZE;
      binGreen = (unsigned int) (cim.g[i][j] * BINS) / COLOR_RANGE_SIZE;
      binBlue = (unsigned int) (cim.b[i][j] * BINS) / COLOR_RANGE_SIZE;

      h[binRed][binGreen][binBlue] ++;
    }
  }
}

static void calculateProportion(CIMAGE cim, Array *svmFormat, int h[BINS][BINS][BINS]) {
  unsigned int iter = 0;
  unsigned int nbPixels = cim.nx * cim.ny;

  for (size_t b = 0; b < BINS; b++) {
    for (size_t g = 0; g < BINS; g++) {
      for (size_t r = 0; r < BINS; r++) {
        iter++;
        if (h[r][g][b] != 0){
          insertSvnArray(svmFormat, iter, (float) h[r][g][b] / nbPixels);
        }
      }
    }
  }
}
