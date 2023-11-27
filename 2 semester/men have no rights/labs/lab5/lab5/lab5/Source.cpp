#include <iostream>
#include <string.h>
#include <stdlib.h>
//kjf def efjeee dhd eee
using namespace std;
int main()
{
	char str[80], stress[80], strab[80] = "", seps[] = " ,\n\t", * token, * nexttoken, * ptr, *ptr1;
	bool f = false;
	ptr1 = new char[80];
	cout << "enter string: " << "\n";
	gets_s(str, 80);
	strcpy_s(stress, str);
	token = strtok_s(stress, seps, &nexttoken);
	ptr1 = &str[0];
	cout << "the adresses of deleted elemets: \n";
	while (token != nullptr) {
		if (strstr(token, "ee") == nullptr) {
			strcat_s(strab, token); strcat_s(strab, " ");
		}
		else {
			ptr = strstr(ptr1, token);
			printf("%p\n", &ptr[0]);
			f = true;
		}
		 ptr1 = ptr1 + strlen(token)+1;
		token = strtok_s(nullptr, seps, &nexttoken);
	}
	if (f == false) cout << "no one\nThe string: "<<str;
	else cout << "the former string: " << str << "\n" << "the final one: " << strab << "\n\n";
	ptr1 = nullptr;
	delete [80] ptr1;
	return 0;
}