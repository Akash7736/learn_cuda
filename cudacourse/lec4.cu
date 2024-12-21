// Launch Configuration for Large Size 
// When my indexing exceeds 1024  in 1D 

#include <stdio.h>
#include <cuda.h>

__global__ void dkernel(unsigned *vector, unsigned vectorsize){
    unsigned id = blockIdx.x * blockDim.x + threadIdx.x; 
    if (id < vectorsize) 
    vector[id] = id; 
}

#define BLOCKSIZE 1024

int main(int nn, char *str[]){ // first arg nn denotes total number of args wjile running the program "./lec4 hello world" nn = 3
                              // second arg str is an array of args after program name {"lec4","hello", "world"}

    unsigned N = atoi(str[1]);
    unsigned *vector , *hvector; 
    cudaMalloc(&vector, N * sizeof(unsigned));
    hvector = (unsigned*)malloc(N * sizeof(unsigned));

    unsigned nblocks = ceil((float)N/BLOCKSIZE); // N/BLOCKSIZE will give truncated value by default so no usage of ceil happens 
    printf("nblocks = %d\n", nblocks);

    dkernel<<<nblocks, BLOCKSIZE>>>(vector, N);
    cudaMemcpy(hvector, vector, N * sizeof(unsigned), cudaMemcpyDeviceToHost);
    for (unsigned i= 0; i < N; ++i){
        printf("%4d ", hvector[i]);
    }
    return 0; 
}