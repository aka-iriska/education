#include <iostream>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
using namespace std;
class TKarta {
private:
	int numb;
	int per;
	float bal;
public:
	TKarta(int an, int ap, float ab) :numb(an), per(ap), bal(ab) {}
	void Print() {
		cout << "Number of a card: " << numb <<
			"$\nThe percent of discount: " << per <<
			"%\nThe balance of card: " << bal << "$\n";
	}
	void buy(int sum) {
		float ss = sum;
		bal = bal + ss * per / 100;
	}
	void spend(int sum) {
		bal = bal - sum;
	}
	float cerBal() { return bal; }
};
int main() {
	int n, p, summ; float b; char s[6];
	srand((unsigned)time(NULL));
	n = 1000 + rand() % (9999 - 1000 + 1);
	p = 1 + rand() % (25 - 1 + 1);
	b = 150 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX / (350 - 150)));
	TKarta card(n, p, b);
	cout << "Data: \n"; card.Print();
	cout << "Input the purchase amount: ";
	cin >> summ; card.buy(summ);
	cout << "Would you like to spend bonuses?\n";
	cin.ignore();
	gets_s(s, 6);//доделать
	if (strcmp(s, "Yes") == 0 || strcmp(s, "yes") == 0) {
		cout << "Input the amount: "; cin >> summ;
		card.spend(summ);
	}
	cout << "The current balance: " << card.cerBal();
	return 0;
}