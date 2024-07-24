#ifndef SYSLABCC_DLLIMPORT
#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)
#define SYSLABCC_DLLIMPORT __declspec(dllimport)
#else
#define SYSLABCC_DLLIMPORT
#endif
#endif

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>
SYSLABCC_DLLIMPORT uint8_t predict(
    float* poutput, 
    float* pinput, 
    int32_t input_size);

#if defined(__cplusplus)
}
#endif

