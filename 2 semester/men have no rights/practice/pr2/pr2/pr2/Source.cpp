#include <iostream>
#include <math.h>
#include <cmath>
using namespace std;
const int N = 256;
struct core {
    char oper[5];   //знак
    int value;    //константа
    core* left;             
    core* right;            
};
//прототипы функций
void print();
void tree(core* r, char str[]);
int position(char st[], char ops[]);
float solve(core* r, bool&key);

char function[N];
core* root;
bool key = true;
int x;

int main (int argc, char* argv[])
{
    int n; float y;
    cout << "Choose the function:\n";
    print();
    cin >> n;
    switch (n) {
    case 1: strcpy_s(function, "2*x"); break;
    case 2: strcpy_s(function, "4*sin(-x)+(x^2-3)"); break;
    case 3: strcpy_s(function, "cos(7*x+2)"); break;
    case 4: strcpy_s(function, "(4-x)*(1+x)"); break;
    case 5: strcpy_s(function, "1/x"); break;
    }
    root = new core;
    tree(root, function);
    cout << "\nInput the value of x:";
    cin >> x;
    y = solve(root, key);
    if (key != false)cout<<y;
    else cout << "Impossible";
    return 0;
}
void print() {
    cout << "1)y=2*x\n2)y=4*sin(-x)+(x^2-3)\n3)y=cos(7*x+2)\n4)y=(4-x)*(1+x)\n5)y=1/x\n";
}
//есть ли "главная" операция
int position(char st[], char ops[]) {
    int i = 0, j = 0, k = 0; int p;
    p = 0;
    while (i < strlen(st) && p == 0) {
        if (st[i] == '(') j++;
        else if (st[i] == ')') k++;
        else if (j == k && strchr(ops, st[i]) != nullptr) p = i;
        i++;
    }
    return p;
}
void tree(core* r, char str[]) {
    char op[6], o[2] = { ' ', '\0' }, o2[3]{ ' ', ' ', '\0' }, strr[N], strl[N],str1[N], * ptr1;
    int nmain, nnn;
    op[0] = '+'; op[1] = '-'; op[2] = '\0';
    nmain = position(str, op);
    op[0] = '*'; op[1] = '/'; op[2] = '\0';
    if (nmain == 0) nmain = position(str, op);
    op[0] = '^'; op[1] = '\0';
    if (nmain == 0) nmain = position(str, op);
    op[0] = '*'; op[1] = '/'; op[2] = '+';
    op[3] = '-'; op[4] = '^'; op[5] = '\0';

    if (nmain != 0) {
        o[0] = str[nmain];
        strcpy_s(r->oper, o);
        strncpy_s(strl, str, nmain);
        strl[nmain] = '\0';
        if (strl[0] == '(' && position(strl, op) == NULL) {
            strcpy_s(strl, &strl[0]+1);
            strl[strlen(strl)-1] = '\0';
        }
        ptr1 = &str[nmain] + 1;
        strcpy_s(strr, ptr1);
        if (strr[0] == '(' && position(strr, op) == NULL) {
            strcpy_s(strr, &strr[0] + 1);
            strr[strlen(strr)-1] = '\0';
        }
        r->left = new core;
        tree(r->left, strl);
        r->right = new core;
        tree(r->right, strr);
    }
    else
         if (str[0] == 'x'|| strcmp(str, "-x")==0 ){             //переменная
            if (str[0] == 'x') {
                o[0] = 'x';
                strcpy_s(r->oper, o);
                r->left = nullptr;;
                r->right = nullptr;
            }
            else {
                o[0] = '-';
                strcpy_s(r->oper, o);
                strcpy_s(strl, "0");
                strcpy_s(strr, "x");
                r->left = new core;
                tree(r->left, strl);
                r->right = new core;
                tree(r->right, strr);
            }
        }
        else
            if (atoi(str)!=0 || strcmp(str, "0") == 0) {               //константа
                o[0] = 'n';
                strcpy_s(r->oper, o);
                r->left = nullptr;
                r->right = nullptr;
                r->value = atoi(str);
            }
            else {                        //функция
                ptr1 = strchr(str, '(');
                nnn = strlen(str) - strlen(ptr1);
                strncpy_s(str1, str, nnn);
                str1[nnn] = '\0';
                strcpy_s(r->oper, str1);
                r->right = nullptr;
                strcpy_s(strl, ptr1 + 1);
                strl[strlen(strl) - 1] = '\0';
                r->left = new core;
                tree(r->left, strl);
            }
}

float solve(core* r, bool& key) {
    float result;
    if (key)
        if (r->oper[0] == 'n') result = r->value;        //константа
        else if (r->oper[0] == 'x') result = x;
        else {
            switch (r->oper[0]) {
            case '+': result = solve(r->left, key) + solve(r->right, key); break;
            case '-': result = solve(r->left, key) - solve(r->right, key); break;
            case '*': result = solve(r->left, key) * solve(r->right, key); break;
            case '/':
                if (solve(r->right, key) != 0)
                    result = solve(r->left, key) / solve(r->right, key);
                else { key = false; result = 0; }
                break;
            case '^':
                if (solve(r->left, key) == 0 && solve(r->right, key) == 0) {
                    key = false;
                    result = 0;
                }
                else result = pow(solve(r->left, key), solve(r->right, key));
                break;
            case 's': result = sin(solve(r->left, key)); break;
            case 'c': result = cos(solve(r->left, key)); break;
            default: result = 0;
                break;
            }
        }
    return result;
}