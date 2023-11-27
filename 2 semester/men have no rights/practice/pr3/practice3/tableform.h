
#ifndef TABLEFORM_H
#define TABLEFORM_H


#include <QObject>
#include <QWidget>
#include <basefile.h>
#include <QTableWidget>
#include <QPushButton>

class TableForm:public QWidget
{
    QTableWidget *table;
    QPushButton *Exitbtn;
public:
    TableForm();
    void showAll();//показать все записи
    void showRow(int i,recType r);
    void showResults(recType r1);
};

#endif // TABLEFORM_H
