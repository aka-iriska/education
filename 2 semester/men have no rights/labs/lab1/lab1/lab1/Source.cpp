#include "Nod.h"
#include <locale.h> // ��� ����������� �������� �����
#include <stdio.h>  
int main()
{
	int a, b;
	setlocale(0, "russian"); // ����������� �������� �����
	puts("������� ��� ����������� �����:");
	scanf_s("%d %d", &a, &b);
	printf("��� %d � %d = %d.\n", a, b, nod(a, b));
	return 0;
}
