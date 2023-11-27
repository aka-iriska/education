#include <iostream>
#include <stdlib.h>
#include <string.h>
/* sjsad323kw+djh**+-hs293891adf
32aa227sj+s-*wy2+3g59agd
+sie93323+dfiegeife2+_32* 

dsf343+dsfs43awdaw++dsa
sadad4ew++aasasd834e*/
using namespace std;
const char b[] = "qwertyuiopasdfghjklzxcvbnm";
const char ch[] = "1234567890";
const char s[] = "+-*";

void kol(char** list, int k) {
	char* str, * f;
	int cb ,cch,cs;
	bool fb, fch, fs;
	for (int i = 0; i < k; i++) {
		str = list[i];
		cb = cch = cs = 0;
		fb = fch = fs = false;
		f = str;
		while (strcmp(f, "")!=0 ){
			if (strchr(b, f[0]) != nullptr) {
				if (fch == true) cch++;
				if (fs == true) cs++;
				fb = true; fch = false; fs = false;
				f++;
			}
			else {
				if (fb == true) cb++;
				if (strchr(ch, f[0]) != nullptr) {
					if (fs == true) cs++; fch = true;  fb = false; fs = false; f++;
				}
				else {
					if (fch == true) cch++;
					fs = true;
					fch = false;
					fb = false;
					f++;
				}
			}
		}
		if (fb == true) cb++;
		if (fch == true) cch++;
		if (fs == true) cs++;
		cout << "The " << i+1 << " string: " << cb<<" "<<cch << " " << cs << "\n";
	}
}
void zam(char** list, int k) {
	char* str, *f, *r;
	char g[] = "eyuioa";
	for (int i = 0; i < k; i++) {
		char str1[50] = ""; char str2[2]="";
		str = list[i];
		while (strcmp(str, "") != 0) {
			f = str;
			if (strchr(g, f[0]) != nullptr) {
				strcat_s(str1, "aaaa");
				do 
					f++; 
				while (strchr(ch, f[0]) == nullptr && strchr(s, f[0]) == nullptr&& strcmp(f, "") != 0);
			}
			else {
				do {
					strncpy_s(str2, f, 1);
					strcat_s(str1, str2);
					f++;
				} while ((strchr(b, f[0]) != nullptr  || strchr(g, f[1]) == nullptr)&& strcmp(f, "") != 0);
			}
			if (strchr(g, f[1]) != nullptr){
				strncpy_s(str2, f, 1);
				strcat_s(str1, str2);
				f++;
			}
			str = f;
		}
		puts(str1);
	}
}
int main() {
	int kolstr;
	cout << "The amount: \n";
	cin >> kolstr;
	char** listnew = new char* [kolstr];
	cout << "The former strings: \n";
	cin.ignore();
	for (int i = 0; i < kolstr; i++)
	{
		char* str = new char[51];
		gets_s(str, 50);
		listnew[i] = str;
	}
	kol(listnew, kolstr);
	cout << "The result string \n";
	zam(listnew, kolstr);
	for (int i = 0; i < kolstr; i++) delete[] listnew[i];
	delete[]listnew;
}
