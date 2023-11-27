#include <iostream>
#include <cmath>
#include <math.h>
using namespace std;
class circle {
protected:
	int diam;
public:
	circle(int ad) : diam(ad) {}
	circle() {}
	float square() {
		float sq; int r;
		r = diam / 2;
		sq = 3.14*pow(r, 2);
		return sq;
	}
	void print() {
		cout << "The diametr: " << diam<<endl;
		cout << "The square of circle: " << square();
	}
};
class pan :public circle {
private:
	char material[22];
public:
	pan(int ad, char am[22]):circle(ad){
		strcpy_s(material, am);
	}
	pan() {}
	void print() {
		circle::print();
		cout << "\nThe material: " << material<<endl;
	}
	int kotlet(float sq) {
		float Sq;
		Sq=circle::square();
		return trunc(Sq / sq);
	}
};
int main() {
	int d; float square; char m[22];
	cout << "Input the diametr: \n";
	cin >> d;
	cout << "The circle: \n----------- \n";
	circle Krug(d);
	Krug.print();
	//--------
	cout << "\nInput the material: \n";
	cin.ignore();
	gets_s(m, 22);
	cout << "Input the square of meatballs: \n";
	cin >> square;
	pan Skov(d, m);
	cout << "The pan: \n----------- \n";
	Skov.print();
	cout << "The amount of meatballs: " << Skov.kotlet(square);
	return 0;
}
