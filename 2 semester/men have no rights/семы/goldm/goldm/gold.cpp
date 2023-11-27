#include <cmath>
#include <stdio.h>
#include <algorithm>
using namespace std;

int getMaxTrace(int a[5][5], int col, int row) {
    int res = a[row][col];
    if (row != 4) {
        int left = getMaxTrace(a, col, row + 1);
        int right = getMaxTrace(a, col + 1, row + 1);
        res += max(left, right);
    }
    return res;
}
int main() {
    const int row = 5, col = 5;
    int A[row][col], a, r=0;
    for (int i = 0; i < row; ++i)
        for (int j = 0; j <= i; ++j) {
            scanf_s("%d", &a);
            A[i][j] = a;
        }
    for (int i = 0; i < row; ++i){
        for (int j = 0; j <= i; ++j) {
            printf_s("%d ", A[i][j]);
        }
        printf_s("\n");
        }
    r=getMaxTrace(A, 0, 0);
    printf_s("maximum sum %d", r);
    return 0;
}
