
#include "element.h"

void Spisok::Add(Element*e, bool f){
    if (first==nullptr) first=last=e;
    else{if (f==0){e->suc=first;
            first->pre=e;
            first=e;}
        else {
            cur=last;
            cur->suc=e;
            e->pre=cur;
            cur=e;
            last=e;}}
}
void Spisok::Del(bool p){
    if(p==1){
        if (last!=nullptr){
            last=last->pre;
            if (last!=nullptr)last->suc=nullptr;}
    }
    else {
        if (first!=nullptr){
            first=first->suc;
            if (first!=nullptr)first->pre=nullptr;
        }
    }
    if (last==nullptr)first=nullptr;
}
