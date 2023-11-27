#include <locale.h>
#include <stdlib.h>
#include <iostream>
#include <string.h>
#include<string>
#include <conio.h>
using namespace std;
const int kol = 15;
class Bash                 
{
protected:
    char str[10]; 
    int height;
    bool pr;
public:
    Bash() {}
    Bash(char s[10], int h, bool p) { strcpy_s(str, s); height = h; pr = p;}
    ~Bash() {}          
    void print(void)    
    { cout << "Название: " << str << "\nВысота: "<<height<<"\nПроездная: "<<pr<<"\n"; }
    void Init(char s[10], int h, bool p) { strcpy_s(str, s); height = h; pr = p; }
    char* Name() {return str;}
    int High() { return height; }
    bool Proezd() { return pr; }
};
class Krep  
{
private: 
    char name[22]="КРЕПОСТЬ";
    int  size;   
    Bash mas[kol]; 
public:
    Krep() {}    
    Krep(int af, Bash m1[kol]) 
    {
        setmas(af, m1);
    }
    ~Krep() {}   
    void  printm();  
    void setmas(int af, Bash m1[]);
    int kol();
    string thehighest();
};
void Krep::setmas(int af, Bash m1[])
{
    int i;
    size = af;
    for (i = 0; i < size; i++)   mas[i].Init(m1[i].Name(), m1[i].High(), m1[i].Proezd());
}
void Krep::printm()
{
    int  i; char h[10];
    cout<<"----------\nСодержимое объекта:"<<name<<"\n";
    for (i = 0; i < size; i++) {
        cout << i+1 << ":";  mas[i].print();
    }
    cout << "Количество проездных башен: " << kol();
    cout << "\nНазвание самой высокой башни: " << thehighest();
}
int Krep::kol() {
    int k=0;
    for (int i = 0; i < size; i++) {
        if (mas[i].Proezd() == 1) k += 1;
    }
    return k;
}
string Krep::thehighest() {
    int max = 0; char name[10];
    for (int i = 0; i < size; i++) {
        if (mas[i].High() > max) {
            max = mas[i].High();
            strcpy_s(name, mas[i].Name());
        }
    }
    return name;
}
int main()
{
    setlocale(0, "russian");
    int numb; char name[10]; int h; bool p;
    cout << "Введите число башен: \n";
    cin >> numb;
    Bash mn[kol]; Bash A;
    for (int i = 0; i < numb; i++) {
        cout << "the " << i+1 << " tower:\nname: ";
        cin.ignore();
        //cin >> name;
        gets_s(name, 10);
        //cin.ignore();
        cout << "the height:"; cin >> h;
        cout << "proezd (0/1) ? "; cin >> p;
        A.Init(name, h, p);
        mn[i] = A;
    }
    Krep a(numb, mn);
    a.printm();
    return 0;
}
