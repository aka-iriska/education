//описание самого списка
#ifndef ELEMENT_H
#define ELEMENT_H
#include <iostream>
#include <string>
#include <string.h>
#include <stdlib.h>
#include "Num.h"
using namespace std;

class Spisok{
protected: Element*first, *last, *cur;
public: Spisok(){first=last=cur=nullptr;}
    ~Spisok(){
        while (cur=first, cur!=nullptr){
            first=first->suc;
            delete cur;
        }
    };
    void Add(Element*a, bool f);//добавление элемента
    void Del(bool f);//удаление элемента
    Element *First(){return cur=first;}
    Element *Next(){return cur=cur->suc;}
    Element *Last(){return cur=last;}
    Element *Prev(){return cur=cur->pre;}
};
class summa:public Spisok{
public:
    summa():Spisok(){}
    int Summa(){
        int k, s=0;
        cur=first;
        while(cur!=nullptr){
            if (TNum *q=dynamic_cast<TNum*> (cur)) {
                k = q->num;
                s+=k;
            }
            cur=cur->suc;
        }
        return s;
    }
};

#endif // ELEMENT_H
