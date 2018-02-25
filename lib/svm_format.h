#include <stdlib.h>

typedef struct {
  unsigned int number;
  float value;
} SvmFormat;

typedef struct {
  SvmFormat *array;
  size_t used;
  size_t size;
  size_t label;
} Array;

void newSvnArray(Array *a, size_t initialSize, size_t label);
void insertSvnArray(Array *a, unsigned int number, float value);
void freeSvnArray(Array *a);
void displaySvnArray(Array *a);
