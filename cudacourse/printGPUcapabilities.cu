#include <stdio.h>
#include <cuda_runtime.h>

int main() {
    cudaDeviceProp prop;
    int device;

    // Get the current device ID
    cudaGetDevice(&device);

    // Get the properties of the current device
    cudaGetDeviceProperties(&prop, device);

    // Print device name and memory properties
    printf("Device Name: %s\n", prop.name);
    printf("Shared Memory Per Block: %lu bytes\n", prop.sharedMemPerBlock);
    printf("Shared Memory Per Multiprocessor: %lu bytes\n", prop.sharedMemPerMultiprocessor);
    printf("Registers Per Block: %d\n", prop.regsPerBlock);
    printf("Max Threads Per Block: %d\n", prop.maxThreadsPerBlock);
    printf("Max Registers Per Thread: %d\n", prop.regsPerBlock / prop.maxThreadsPerBlock);
    printf("Total Constant Memory: %lu bytes\n", prop.totalConstMem);
    printf("Warp Size: %d threads\n", prop.warpSize);
    printf("Maximum Memory Pitch: %lu bytes\n", prop.memPitch);
    printf("Global Memory: %lu MB\n", prop.totalGlobalMem / (1024 * 1024));
    printf("Max Threads Dim (per block): %d x %d x %d\n",
           prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
    printf("Max Grid Size (blocks): %d x %d x %d\n",
           prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
    printf("Max Blocks per Dimension (Grid): %d x %d x %d\n", 
           prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
    return 0;
}
