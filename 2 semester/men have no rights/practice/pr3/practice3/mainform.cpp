
#include "mainform.h"
#include "basefile.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
mainForm::mainForm()
{
    this->setWindowTitle("Овощная база");
    Exitbtn= new QPushButton("Выйти");
    mostbtn=new QPushButton("Какого товара больше всего?");
    muchbtn=new QPushButton("Сколько кг можно купить");
    benbtn=new QPushButton("Самый выгодный пооставщик");
    gystbtn=new QPushButton("Гистограмма");
    namel=new QLabel("Имя товара");
    namee=new QLineEdit;
    provl=new QLabel("Поставщик");
    prove=new QLineEdit;
    amountl=new QLabel("Количество в наличии (кг)");
    amounte=new QLineEdit;
    pricel=new QLabel("Цена (за 1 кг)");
    pricee=new QLineEdit;
    addbtn=new QPushButton("Добавить");
    delbtn=new QPushButton("Удалить");
    tablebtn= new QPushButton("Таблица");
    namee->setFocus();
    QVBoxLayout* right = new QVBoxLayout ();
    right->addWidget(mostbtn);
    right->addWidget(muchbtn);
    right->addWidget(benbtn);
    right->addWidget(gystbtn);
    right->addWidget(Exitbtn);
    QHBoxLayout* adde =new QHBoxLayout();
    adde->addWidget(addbtn);
    adde->addWidget(delbtn);
    QGridLayout*left = new QGridLayout();
    left->addWidget(namel, 1, 1);
    left->addWidget(provl, 2, 1);
    left->addWidget(amountl, 3, 1);
    left->addWidget(pricel, 4, 1);
    left->addWidget(namee, 1, 2);
    left->addWidget(prove, 2, 2);
    left->addWidget(amounte, 3, 2);
    left->addWidget(pricee, 4, 2);
    left->addLayout(adde, 5, 2);
    left->addWidget(tablebtn, 6, 2);
    QHBoxLayout* layout2=new QHBoxLayout();
    layout2->insertLayout(0, right, 0);
    layout2->insertStretch(1, 0);
    layout2->insertLayout(2, left, 0);
    setLayout(layout2);
    resize(600, 300);//размеры окна
    connect(Exitbtn, SIGNAL(clicked(bool)), this, SLOT(close()));
    connect(addbtn, SIGNAL(clicked(bool)),this,SLOT(addRecord()));
    connect(delbtn, SIGNAL(clicked(bool)),this,SLOT(delRecord()));
    //другие формы:
    connect(mostbtn, SIGNAL(clicked(bool)),this,SLOT(mostAmount()));
    connect(muchbtn, SIGNAL(clicked(bool)),this,SLOT(muchBuy()));
    connect(benbtn, SIGNAL(clicked(bool)),this,SLOT(benProvider()));
    connect(gystbtn, SIGNAL(clicked(bool)),this,SLOT(printGyst()));
    connect(tablebtn, SIGNAL(clicked(bool)),this,SLOT(printTable()));
}
void mainForm::addRecord(){
    baseFile base;
    recType r;
    r.name=namee->text();
    r.prov=prove->text();
    r.amount=amounte->text();
    r.price=pricee->text();
    namee->clear();
    prove->clear();
    amounte->clear();
    pricee->clear();
    base.addRec(r);
    namee->setFocus();
}
void mainForm::delRecord(){
    baseFile base;
    recType r;
    r.name=namee->text();
    r.prov=prove->text();
    //r.amount=amounte->text();
    //r.price=pricee->text();
    namee->clear();
    prove->clear();
    amounte->clear();
    pricee->clear();
    base.delRec(r);
    namee->setFocus();
}
//показать другие формы
void mainForm::mostAmount(){
    winMost.show();
}
void mainForm::muchBuy(){
    winMuch.show();
}
void mainForm::benProvider(){
    winBen.show();
}
void mainForm::printGyst(){
    winGyst.show();
}
void mainForm::printTable(){
    winTable.showAll();
}

