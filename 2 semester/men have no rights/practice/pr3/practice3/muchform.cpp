
#include "muchform.h"
#include <QGridLayout>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QMessageBox>

muchForm::muchForm()
{
    this->setWindowTitle("Сколько кг можно купить на сумму");
    prevbtn = new QPushButton("Предыдущий");
    inputbtn= new QPushButton("Вывести");
    sucbtn=new QPushButton("Следующий");
    exitbtn=new QPushButton("Меню");
    inputl=new QLabel("Введите сумму");
    inpute=new QLineEdit;
    namel=new QLabel("Товар");
    namee=new QLineEdit;
    namee->setReadOnly(true);
    provl=new QLabel("Поставщик");
    prove=new QLineEdit;
    prove->setReadOnly(true);
    pricel=new QLabel("Цена за 1 кг");
    pricee=new QLineEdit;
    pricee->setReadOnly(true);
    massl=new QLabel("Масса");
    masse=new QLineEdit;
    masse->setReadOnly(true);
    prevbtn->setEnabled(false);
    QGridLayout*layout=new QGridLayout();
    layout->addWidget(namel, 1, 1);
    layout->addWidget(namee, 1, 2);
    layout->addWidget(provl, 2, 1);
    layout->addWidget(prove, 2, 2);
    layout->addWidget(pricel, 3, 1);
    layout->addWidget(pricee, 3, 2);
    layout->addWidget(massl, 4, 1);
    layout->addWidget(masse, 4, 2);
    layout->addWidget(prevbtn, 5, 1);
    layout->addWidget(inputbtn, 5, 2);
    layout->addWidget(sucbtn, 5, 3);
    layout->addWidget(exitbtn, 6, 2);
    QHBoxLayout*layouttop=new QHBoxLayout();
    layouttop->addWidget(inputl);
    layouttop->addWidget(inpute);
    QVBoxLayout*all=new QVBoxLayout();
    all->insertLayout(0, layouttop, 0);
    all->insertLayout(1, layout, 0);
    setLayout(all);
    connect(exitbtn, SIGNAL(clicked(bool)), this, SLOT(closeform()));
    connect(prevbtn, SIGNAL(clicked(bool)), this, SLOT(printprev()));
    connect(sucbtn, SIGNAL(clicked(bool)), this, SLOT(printsuc()));
    connect(inputbtn, SIGNAL(clicked(bool)), this, SLOT(printinf()));
}
void muchForm::closeform(){
    Spis*r=first;
    while (r=first, first!=nullptr){
        first=first->p;
        delete r;
    }
    close();
}
void muchForm::printsuc(){
    j+=1;
    prevbtn->setEnabled(true);
    printinf();
}
void muchForm::printprev(){
    j-=1;
    sucbtn->setEnabled(true);
    printinf();
}
void muchForm::printinf(){
    int summa=inpute->text().toInt(), h;
    first=createsp(); Spis *r;
    r=first;
    for (int i=0; i<j; i++) r=r->s;
    namee->setText(r->nam);
    prove->setText(r->pro);
    pricee->setText(r->pr);
    h=summa/r->pr.toInt();
    if (h<=r->am.toInt()){
        QString str=QString::number(h);
        masse->setText(str);
    }
    else masse->setText(r->am);
    if (r->s==nullptr) sucbtn->setEnabled(false);
    if (r->p==nullptr) prevbtn->setEnabled(false);
}
Spis* createsp(){
    baseFile base;
    bool fff = base.FromFirst();
    Spis*first, *r, *r1;
    if (fff==false){QMessageBox msg(QMessageBox::Critical, "Файл не найден",
                        "Файл base.txt не создан",
                        QMessageBox::Ok,0);
        msg.exec();
    }
    else {
        first=new Spis;
        first->nam=base.r.name;
        first->pro=base.r.prov;
        first->am=base.r.amount;
        first->pr=base.r.price;
        first->p=nullptr;
        first->s=nullptr;
        r=first;
        while (fff=base.readRec(), fff){
        r1=new Spis;
        r1->nam=base.r.name;
        r1->pro=base.r.prov;
        r1->am=base.r.amount;
        r1->pr=base.r.price;
        r1->p=r;
        r1->s=nullptr;
        r->s=r1;
        r=r1;
        }
    }
    r=first;
    return first;
}
