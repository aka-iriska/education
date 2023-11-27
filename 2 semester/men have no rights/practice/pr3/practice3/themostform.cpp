
#include "themostform.h"

#include "QVBoxLayout"


themostForm::themostForm()
{
    this->setWindowTitle("Какого товара больше всего?");
    countbtn=new QPushButton("Посчитать");
    exitbtn=new QPushButton("Меню");
    resulte=new QLineEdit;
    resulte->setReadOnly(true);
    QVBoxLayout* layout=new QVBoxLayout();
    layout->addWidget(countbtn);
    layout->addWidget(resulte);
    layout->addWidget(exitbtn);
    setLayout(layout);
    resize(300,150);
    resulte->clear();
    connect(countbtn, SIGNAL(clicked(bool)), this, SLOT(prCount()));
    connect(exitbtn, SIGNAL(clicked(bool)), this, SLOT(close()));
}
void themostForm::prCount(){
    int max = 0;
    QString str;
    baseFile base;
    bool fff = base.FromFirst();
    if (fff==false) resulte->setText("0");
    else {
    Spisok *first=new Spisok;
    first->name=base.r.name;
    str=base.r.amount;
    first->k=str.toInt();
    //first->allpr=base.r.price.toInt();
    //first->count=1;
    first->p=nullptr;
    Spisok*r, *r1;
    while (fff=base.readRec(), str=base.r.amount, fff){
        r=first;
        bool find=false;
        while (r!=nullptr&&find==false){
            if (base.r.name==r->name) {
                r->k+=str.toInt();
                //r->allpr+=base.r.price.toInt();
                //r->count+=1;
                find=true;}
            else{
                if(r->p!=nullptr)r=r->p;
                else{
               r1=new Spisok;
               r1->name=base.r.name;
               r1->k=str.toInt();
               //r->allpr=base.r.price.toInt();
               //r->count=1;
               r1->p=nullptr;
               r->p=r1;
               r=r1;
               find=true;}
            }
        }
    }
    r=first;r1=first;
    while (r!=nullptr){
        if (r->k>max){
            str=r->name;
            max=r->k;
        }
        r=r->p;
        delete r1;
        r1=r;
    }
    resulte->setText(str);
    }
}

