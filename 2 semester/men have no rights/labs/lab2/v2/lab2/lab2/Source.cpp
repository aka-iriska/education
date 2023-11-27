#include <locale.h> 
#include <stdio.h>
#include <cmath>
int main()
{
	int x, a;
	float s0 = 0, s1 = 0;
	setlocale(0, "russian"); // подключение русского языка
	puts("Введите x");
	scanf_s("%d", &x);
	while (x > 0) {
		a = x % 10;
		x = x / 10;
		if (a % 2 == 0)
			s0 = s0 + a;
		else s1 = s1 + a;
	}
	printf("Полусумма четных цифр = %7.2f.\n", s0 / 2);
	printf("Полусумма нечетных цифр = %7.2f.\n", s1 / 2);
	return 0;
}

