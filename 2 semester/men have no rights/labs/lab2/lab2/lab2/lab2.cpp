#include <locale.h> 
#include <stdio.h>
#include <cmath>
int main()
{
	int x,  y;
	setlocale(0, "russian"); // ����������� �������� �����
	puts("������� x");
	scanf_s("%d", &x);
	if (cos(pow(x, 3) - 5) != 0 and sin(pow(x, 3) - 5) != 0) {
		y = (exp(x) * cos(pow(x, 3) - 5) / sin(pow(x, 3) - 5) + pow(x, 2));
		printf("y = %d.\n", y);
	}
	else printf("�������� y �� ����������");
	return 0;
}
