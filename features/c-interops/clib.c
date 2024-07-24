#include <stdint.h>
typedef double (*int_func)(double);

double c_sum(int_func f, double* data, int32_t n)
{
    double sum = 0;
    for (int32_t i = 0; i < n; i++)
    {
        sum += f(data[i]);
    }
    return sum;
}
