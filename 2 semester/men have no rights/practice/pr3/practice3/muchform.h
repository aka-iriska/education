
#ifndef MUCHFORM_H
#define MUCHFORM_H


#include <QObject>
#include <QWidget>
#include <QPushButton>
#include <QLineEdit>
#include <QLabel>

#include <basefile.h>

class muchForm:public QWidget
{
    Q_OBJECT
    int j=0;
    Spis*first;
    QPushButton* prevbtn;
    QPushButton* inputbtn;
    QPushButton* sucbtn;
    QPushButton* exitbtn;
    QLabel* inputl;
    QLineEdit* inpute;
    QLabel* namel;
    QLineEdit* namee;
    QLabel* provl;
    QLineEdit* prove;
    QLabel* pricel;
    QLineEdit* pricee;
    QLabel* massl;
    QLineEdit* masse;
    friend Spis* createsp();
public:
    muchForm();
public slots:
    void printinf();
    void printsuc();
    void printprev();
    void closeform();
};
Spis* createsp();
#endif // MUCHFORM_H
