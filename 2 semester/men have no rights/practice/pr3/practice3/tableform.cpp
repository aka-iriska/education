#include "mainform.h"
#include "tableform.h"
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QMessageBox>
TableForm::TableForm()
{
    this->setWindowTitle("Все записи");
    QStringList strlist;
    strlist<<("Имя товара")<<"Производитель"<<"Количество"<<"Цена";
    table=new QTableWidget(20, 4, this);
    table->setHorizontalHeaderLabels(strlist);
    QHBoxLayout*layout=new QHBoxLayout();
    Exitbtn=new QPushButton("Меню");
    layout->addWidget(Exitbtn);
    QVBoxLayout*layout1=new QVBoxLayout();
    layout1->addWidget(table);
    layout1->addLayout(layout);
    setLayout(layout1);
    connect(Exitbtn, SIGNAL(clicked(bool)), this, SLOT(close()));
}
void TableForm::showRow(int i,recType r)
{
    QTableWidgetItem *item; // элемент таблицы
    item = new QTableWidgetItem(); // создаем элемент
    item->setFlags(Qt::NoItemFlags);//запрещаем выделение
    item->setText(r.name);   // записываем текст
    table->setItem(i,0,item);// привязываем элемент к таблице
    item = new QTableWidgetItem();// создаем элемент
    item->setFlags(Qt::NoItemFlags); //запрещаем выделение
    item->setText(r.prov);
    table->setItem(i,1,item); // привязываем элемент
    item = new QTableWidgetItem();// создаем элемент
    item->setFlags(Qt::NoItemFlags); //запрещаем выделение
    item->setText(r.amount); // записываем текст
    table->setItem(i,2,item); // привязываем элемент
    item = new QTableWidgetItem();// создаем элемент
    item->setFlags(Qt::NoItemFlags); //запрещаем выделение
    item->setText(r.price); // записываем текст
    table->setItem(i,3,item);
}
void TableForm::showAll()
{
    baseFile base;
    if (!base.FromFirst())
    {    // если файл пустой , то создаем сообщение
        QMessageBox msg(QMessageBox::Critical,
                        "Нет данных",
                "База пуста",
                        QMessageBox::Ok,0);
        msg.exec(); // выводим сообщение
    }
    else
    {   // иначе - выводим таблицу по строкам
        showRow(0,base.r);
        int i=0;
        while (base.readRec())
            showRow(++i,base.r);
        table->setRowCount(i+1);
        resize(600,400);
        show();
    }
    base.FromFirst();
}
void TableForm::showResults(recType r1)
{
    baseFile base;
    //base->reset();
    if (!base.findFirst(r1))
    {   // если данные не найдены, то создаем сообщение
        QMessageBox msg(QMessageBox::Critical,
                        "Нет данных",
              "Данные не найдены",
                        QMessageBox::Ok,0);
        msg.exec();
    }
    else
    {   // иначе - выводим результаты  по строкам
        showRow(0,base.r);
        int i=0;
        while (base.findNext(r1))
            showRow(++i,base.r);
        table->setRowCount(i+1);
        resize(350,200);
        show();
    }
}

