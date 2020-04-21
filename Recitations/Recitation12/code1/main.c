#include <stdio.h>

static int a = 1;
int* a_ptr = &a;
void modify_a();

int main() {
    modify_a();
    printf("%d\n", a);
}