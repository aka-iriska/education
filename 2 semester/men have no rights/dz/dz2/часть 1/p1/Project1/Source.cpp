#include <string.h>
#include <iostream>
#include <stdlib.h>

using namespace std;
bool pal (char *s) {
	int i, j, k=0;
	j = strlen(s);
	for (i = 0; i < j/ 2; i++)
		if (s[i] == s[j - i - 1]) k++;
	if (k == j / 2) return true;
	else return false;
}
char* rev(char*str) {
	int i = 0;
	while (str[i]) i++; //считаем длину строки
	for (int j = 0; j < i / 2; j++)
	{
		swap(str[j], str[i - j - 1]);
	}
	return str;
}
int main() {
	int i, n;
	char str1[11], str[11], ch[3];
	for (i = 1; i <= 106; i++) {
		strcpy_s(str1, "");
		n = i;
		while (n != 0) {
			_itoa_s(n % 2, ch, sizeof(ch), 10);
			strcat_s(str1, ch);
			n /= 2;
		}
		rev(str1);
		_itoa_s(i, str, sizeof(str), 10);
		if (pal(str) == pal(str1)&&pal(str)==true)
		cout << i << " " << str1 << "\n";
	}
	return 0;
}