
#include "benproform.h"
//#include "muchform.h"
#include <QGridLayout>
#include <QVBoxLayout>
#include <QHBoxLayout>
BenProForm::BenProForm()
{
    this->setWindowTitle("Поиск самого выгоодного поставщикф");
    inputbtn= new QPushButton("Вывести");
    exitbtn=new QPushButton("Меню");
    inputNl=new QLabel("Введите наименование товара");
    inputNe=new QLineEdit;
    outputPl=new QLabel("Самый выгодный поставщик");
    outputPe=new QLineEdit;
    inputNe->clear();
    outputPe->clear();
    inputNe->setFocus();
    outputPe->setReadOnly(true);
    QGridLayout*layout=new QGridLayout();
    layout->addWidget(inputNl, 1, 1);
    layout->addWidget(inputNe, 1, 2);
    layout->addWidget(outputPl, 2, 1);
    layout->addWidget(outputPe, 2, 2);
    layout->addWidget(inputbtn, 3, 1);
    layout->addWidget(exitbtn, 3, 2);
    setLayout(layout);
    connect(exitbtn, SIGNAL(clicked(bool)), this, SLOT(close()));
    connect(inputbtn, SIGNAL(clicked(bool)), this, SLOT(printBen()));
}
void BenProForm::printBen(){
    QString str=inputNe->text(), result;int min=1000;
    baseFile base;
    bool fff=base.FromFirst();
    while(fff){
        if (base.r.name==str&&base.r.price.toInt()<min){
            result=base.r.prov;
            min=base.r.price.toInt();}
    fff=base.readRec();
    }
    outputPe->setText(result);
}
