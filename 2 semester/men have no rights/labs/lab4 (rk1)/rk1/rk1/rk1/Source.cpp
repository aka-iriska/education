#include <iostream>
#include <stdlib.h>
using namespace std;
int main()
{
	int i, j;
	double a[5][5];
	cout << "Former:"<<"\n";
	for (i = 0; i < 5; i++) {
		for (j = 0; j < 5; j++) {
			a[i][j] = float(50+10)*rand()/RAND_MAX-10;
			cout << a[i][j] << ' ';
		}
		cout << "\n";
	}
	int mini=10, minj=10; double c;
	for (j = 0; j < 5; j++) {
		for (i = 0; i < 5; i++) {
			if (a[i][j] < 0) { mini = i; minj = j; break; }
		}
		cout << "In the " << j + 1 << " colomn the first negative number: ";
		if ((mini != 10)&&(minj != 10)) cout << a[mini][minj] << " " << &a[mini][minj] << "\n";
		else cout << "no" << "\n";
		if ((mini != 10)&&(minj != 10)) {
			c = a[j][j];
			a[j][j] = a[mini][minj];
			a[mini][minj] = c;
		}
	}
	cout << "Changed:"<<"\n";
	for (i = 0; i < 5; i++) {
		for (j = 0; j < 5; j++) {
			cout << a[i][j] << ' ';
		}
		cout << "\n";
	}
	return 0;
}