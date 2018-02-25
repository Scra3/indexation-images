#include "svm_format.h"

void newSvnArray(Array *a, size_t initialSize, size_t label) {
  a->array = (SvmFormat *)malloc(initialSize * sizeof(SvmFormat));
  a->used = 0;
  a->size = initialSize;
  a->label = label;
}

void insertSvnArray(Array *a, unsigned int number, float value) {
  if (a->used == a->size) {
    a->size *= 2;
    a->array = (SvmFormat *)realloc(a->array, a->size * sizeof(SvmFormat));
  }

  SvmFormat *svn = &(a->array[a->used++]);
  svn->number = number;
  svn->value = value;
}

void freeSvnArray(Array *a) {
  free(a->array);
  a->array = NULL;
  a->used = a->size = 0;
}

void displaySvnArray(Array *a) {
  printf("%d", a->label);
  for (size_t i = 0; i < a->used; i++) {
    SvmFormat *svn = &(a->array[i]);
    printf(" %d: %f", svn->number, svn->value);
  }
  printf("\n");
}
