#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#include "../../lib/rdjpeg.h"
#include "../../lib/svm_format.h"
#include "tri_histo.h"

int main(int argc, char *argv[])
{
  CIMAGE cim;
  Array svmFormat;

  read_cimage(argv[1],&cim);

  calculateTriHisto(cim, &svmFormat);
  displaySvnArray(&svmFormat);

  freeSvnArray(&svmFormat);
  free_cimage(argv[1],&cim);
  exit(0);
}
