
#ifndef BENPROFORM_H
#define BENPROFORM_H


#include <QObject>
#include <QWidget>
#include <QPushButton>
#include <QLineEdit>
#include <QLabel>

#include <basefile.h>
class BenProForm:public QWidget
{
    Q_OBJECT
    QPushButton* inputbtn;
    QPushButton* exitbtn;
    QLabel* inputNl;//имя товара
    QLineEdit* inputNe;
    QLabel* outputPl;//имя производителя
    QLineEdit* outputPe;
public:
    BenProForm();
public slots:
    void printBen();
};

#endif // BENPROFORM_H
