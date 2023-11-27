
#include "stdialog.h"
#include "element.h"
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QDebug>
summa N;
bool f=false;
stDialog::stDialog(QWidget *parent)
{
    this->setWindowTitle("Список");
    Edit= new QLineEdit;
    addb=new QPushButton;
    delb=new QPushButton;
    Exit=new QPushButton;
    s=new QLineEdit;
    slabel=new QLabel;
    Text= new QTextEdit;
    st=new QRadioButton;
    ord=new QRadioButton;
    slabel->setText("Сумма чисел: ");
    addb->setText("Добавить");
    delb->setText("Удалить");
    st->setText("В начало");
    ord->setText("В конец");
    Exit->setText("Выйти");
    Edit->setFocus();
    s->setReadOnly(true);
    Text->setReadOnly(true);
    QVBoxLayout *layout = new QVBoxLayout();
    layout->addWidget(st);
    layout->addWidget(ord);
    layout->addWidget(Edit);
    layout->addWidget(addb);
    //setLayout(layout);
    QVBoxLayout*layout1=new QVBoxLayout();
    layout1->addWidget(delb, 0, Qt::AlignBottom);
    layout1->addWidget(slabel);
    layout1->addWidget(s);
    layout1->addWidget(Exit, 0, Qt::AlignBottom);
    QHBoxLayout *layout2=new QHBoxLayout();
    layout2->addWidget(Text);
    layout2->insertLayout(1, layout1, 0);
    layout2->insertLayout(0, layout, 0);
    setLayout(layout2);
    connect(addb, SIGNAL (clicked()), this, SLOT (clicked()));
    connect(delb, SIGNAL(clicked()), this, SLOT(clicked1()));
    connect(Exit, SIGNAL(clicked()), this, SLOT(close()));
};
void stDialog::clicked(){
    Text->clear();
    QString str = getEdit();
    Element *p, *cur;
    if (str.toInt()!=0){
        QString k=str.at(0);
        p=new TNum(k.toInt());
    }
    else p=new TChar(str.toStdString().c_str()[0]);
    if (st->isChecked()) N.Add(p, 0);
    else if (ord->isChecked()) N.Add(p, 1);
    p=N.First();
    cur=p;
    while(cur!=nullptr){
        if (TNum *q=dynamic_cast<TNum*> (cur)) str=QString::number(q->num);
        if (TChar *q=dynamic_cast<TChar*>(cur)) str=q->ch;
        Text->append(str);
        cur=cur->suc;
    }
    Edit->clear();
    Edit->setFocus();
    str.setNum(N.Summa());
    s->setText(str);
};
void stDialog::clicked1(){
    Text->clear();
    QString str;
    Element *p, *cur;
    if (st->isChecked()) N.Del(0);
    else if (ord->isChecked()) N.Del(1);
    p=N.First();
    cur=p;
    while(cur!=nullptr){
        if (TNum *q=dynamic_cast<TNum*> (cur)) str.setNum(q->num);
        if (TChar *q=dynamic_cast<TChar*>(cur)) str=q->ch;
        Text->append(str);
        cur=cur->suc;
    }
    Edit->clear();
    Edit->setFocus();
    str.setNum(N.Summa());
    s->setText(str);
};
QString stDialog::getEdit(){
    return Edit->text();
};

