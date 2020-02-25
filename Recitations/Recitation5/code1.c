#include <stdio.h> 

void printArray(int arr[]) 
{ 
    int i;
    int arr_size = sizeof(arr) / sizeof(arr[0]);  
    for (i = 0; i < arr_size; i++)
        printf("%d\n", arr[i]); 
} 
  
int main() 
{ 
    int arr[5] = { 1, 2, 3, 4, 5 }; 
    printArray(arr); 
    return 0; 
} 