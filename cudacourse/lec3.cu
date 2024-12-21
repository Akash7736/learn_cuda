// Accesing Dimensions 


// #include <stdio.h>
// #include <cuda.h>

// __global__ void dkernel(){
//     if ( threadIdx.x ==0 && blockIdx.x ==0 && // I want to print only once that's why this condition 
//         threadIdx.y ==0 && blockIdx.y == 0 &&
//         threadIdx .z == 0 && blockIdx.z == 0 ){
//             printf("%d %d %d %d %d %d\n", gridDim.x, gridDim.y, gridDim.z,
//                                         blockDim.x, blockDim.y, blockDim.z);
//         }
// }

// int main() {
//     dim3 grid(2, 3, 4);
//     dim3 block(5, 6, 7); 
//     dkernel<<<grid, block>>>(); // Here grid is just a name, it still indicates the number of thread blocks (2 * 3 * 4) with which kernel is launched
//     // the name block indicates the number and dimension of threads being launched by the kernel 
//     // If instead of (2,3,4) i launch directly as 24 blocks, then it will be a 1D grid. It depends on use case what dimension we need to launch, there is no perfomance penalty in dimensions. 
//     cudaDeviceSynchronize();
//     return 0; 
// }

// // if i remove "threadIdx.x ==0 && blockIdx.x ==0" condition, it will print 5 * 2 times 


//  *********************************************************************

// Write the kernel to initialize the matrix to unique ids 

#include <stdio.h>
#include <cuda.h>

__global__ void dkernel(unsigned *matrix){
    int idx = threadIdx.x * blockDim.y + threadIdx.y;
    matrix[idx] = idx;

}

#define N 5
#define M 6
int main(){
    dim3 block(N, M, 1);
    unsigned *matrix, *hmatrix;
    cudaMalloc(&matrix, N * M * sizeof(unsigned));
    hmatrix  = (unsigned*)malloc(N * M * sizeof(unsigned));
    dkernel<<<1, block>>>(matrix);
    cudaMemcpy(hmatrix, matrix, N * M * sizeof(unsigned), cudaMemcpyDeviceToHost);
    for (unsigned i = 0; i < N; ++i){
        for(unsigned j = 0; j < M; ++j){
            printf("%2d ", hmatrix[i * M + j]);
        }
        printf("\n");
    }
    return 0; 
}