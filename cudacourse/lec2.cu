// Parallelize this C code 

// #include <stdio.h>


// #define N 100

// int main(){

//     int i; 
//     for(int i = 0; i < N; ++i){
//         printf("%d\n", i*i);
//     }
//     return 0; 
// }

// ==============================================

// #include <stdio.h>


// #define N 100

// __global__ void kernel(){
//     int idx = threadIdx.x;
//     printf("%d\n", idx*idx);

// }

// int main(){

//     // int i; 
//     // for(i = 0; i < N; ++i){
//     //     printf("%d\n", i*i);
//     // }
//     kernel<<<1, N>>>();
//     cudaDeviceSynchronize();

//     return 0; 
// }



// *****************************************
// Parallelize the C program 

// #include <stdio.h>


// #define N 100

// int main(){

//     int a[N], i; 
//     for(int i = 0; i < N; ++i){
//         a[i] = i*i;
//     }
//     return 0; 
// }

// ==============================================

// #include <stdio.h>


// #define N 100

// __global__ void kernel(int *a){
//     int idx = threadIdx.x;
//     a[idx] =  idx*idx;

// }

// int main(){


//     int *a;
//     int *a_gpu; // a_gpu pointer variable declared on CPU
//     a = (int *) malloc(N*sizeof(int));
//     cudaMalloc((void **) &a_gpu, N * sizeof(int)); // Memory allocation is done on GPU and 
//     // its memory address is stored in a_gpu. now a_gpu is pointing to a memory in GPU

//     cudaMemcpy(a_gpu, a, N * sizeof(int), cudaMemcpyHostToDevice ); // arg order --> destination and source
//     // in cudaMemcpy we pass adresses, so we copy data from location with adress 'a' to location with adress 'a_gpu'
//     // cudaMemcpy only accepts pointers as arguments
//     // the pointer variables declared in main function are stored in CPU but those declared inside kernal function are stored in GPU
//     kernel<<<1, N>>>(a_gpu);
//     // cudaDeviceSynchronize();
//     cudaMemcpy(a, a_gpu, N * sizeof(int), cudaMemcpyDeviceToHost );
//     // We dont need cudaDeviceSynchronize() if we use cudaMemcpy() the execution is blocked and code waits to finish the kernal
//     // cudaMemcpy() transfer happemns through PCI express bus which has a limited bandwidth so it can be a bottleneck if not carefully used
//     for(int i =0; i < N; i++){
//         printf("%d\n", a[i]);
//     }

//     return 0; 
// }


// ***************************************************************************************************

// Write a CUDA program to initialize  an array of size 32 to all zeros in parallel.
// change the array size to 1024 
// Create another kernel that adds i to array[i]
// Change the array size to 8000
// Check if answer to problem 3 still works 

#include <stdio.h>
#define N 8000
__global__ void kernel(int *arr){
    int idx = blockIdx.x*1024 + threadIdx.x; 
    if (idx<8000) {
    arr[idx] =  idx;
    }

}

int main(){
    int *darr;
    // harr = (int *)malloc(N*sizeof(int));
    int harr[N];
    cudaMalloc(&darr, N * sizeof(int));
    // cudaMemcpy(darr, harr, N * sizeof(int),cudaMemcpyHostToDevice); // Not necessary  here as array is initialized on GPU
    kernel<<<8,1024>>>(darr);
    cudaMemcpy(harr, darr, N*sizeof(int), cudaMemcpyDeviceToHost);
    for(int i=0; i<N; i++){
        printf("%d\n", harr[i]);
    }
    cudaFree(darr);
    return 0;
}

// when array size is 8000 with kernel function kernel<<<1,N>>>(darr); thenit will give garbage values at end
// threadblock - there is limit for the second term in kernel function call which is 1024. 

// ********************************************************************

