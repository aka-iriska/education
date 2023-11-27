
#ifndef NUM_H
#define NUM_H
class Element
{
public:
    Element *pre, *suc;
    Element(){pre=suc=nullptr;}
    virtual ~Element(){};
};
class TNum:public Element{
public:
    int num;
    TNum(int n):Element(), num(n){}
    ~TNum()override{};
};
class TChar:public Element{
public:
    char ch;
    TChar(char c):Element(), ch(c){}
    ~TChar()override{};
};

#endif // NUM_H
