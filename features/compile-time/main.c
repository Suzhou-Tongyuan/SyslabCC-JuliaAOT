#include "libpredict.h"
#include <stdio.h>
#include <stdlib.h>

void display_column_major_array(float* data, int nrow, int ncol)
{
    for (int i = 0; i < nrow; i++)
    {
        for (int j = 0; j < ncol; j++)
        {
            printf("%f ", data[j * nrow + i]);
        }
        printf("\n");
    }
    fflush(stdout);
}

int main()
{
    float input[] = {
        1.2,
        2.2,
        3.2,
        4.2,
        5.2,
        6.2,
        7.2,
        8.2
    };
    float output[8] = { 0 } ;
    if (predict(output, input, 4))
    {
        printf("Error in prediction\n");
        exit(1);
    }

    printf("cpu_model([1.2 3.2 5.2 7.2;2.2 4.2 6.2 8.2]) =\n");
    display_column_major_array(output, 2, 4);
    return 0;
}

// expects: Float32[-39.93754 -80.22664 -88.27775 -89.3798; 36.684155 81.45775 90.40177 91.62443]
