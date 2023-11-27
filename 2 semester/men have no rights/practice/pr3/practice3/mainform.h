
#ifndef MAINFORM_H
#define MAINFORM_H

#include "gystform.h"
#include <QWidget>
#include <QPushButton>
#include <QLabel>
#include <QLineEdit>

#include <TableForm.h>
#include <themostform.h>
#include <muchform.h>
#include <benproform.h>
#include <gystForm.h>

class mainForm : public QWidget
{
    Q_OBJECT
    QPushButton* Exitbtn;
    QPushButton* addbtn;
    QPushButton* delbtn;
    QPushButton* mostbtn;
    QPushButton* muchbtn;
    QPushButton* benbtn;
    QPushButton* gystbtn;
    QPushButton* tablebtn;
    QLabel* namel;
    QLineEdit* namee;
    QLabel* provl;
    QLineEdit* prove;
    QLabel* amountl;
    QLineEdit* amounte;
    QLabel* pricel;
    QLineEdit* pricee;
    TableForm winTable;
    themostForm winMost;
    muchForm winMuch;
    BenProForm winBen;
    gystForm winGyst;
public:
    mainForm();
public slots:
    void addRecord();
    void delRecord();
    void mostAmount();
    void muchBuy();
    void benProvider();
    void printGyst();
    void printTable();
};

#endif // MAINFORM_H
