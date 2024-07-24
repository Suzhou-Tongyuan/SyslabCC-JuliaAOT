#include "libamazing-ad.h"
#include <stdio.h>

int main()
{
    double x = 1.5;
    double y = f_derivative(x);

    printf("x = %f, f'(x) = %f\n", x, y);

    x = 1.2;
    y = f_derivative(x);
    printf("x = %f, f'(x) = %f\n", x, y);

    fflush(stdout);
}