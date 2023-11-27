
#ifndef MOSTPRODUCT_H
#define MOSTPRODUCT_H


#include <QWidget>
#include <QPushButton>
#include <QLineEdit>

class mostproduct:public QWidget
{
    QPushButton* countbtn;
public:
    mostproduct();
public slots:
    void prCount();
};

#endif // MOSTPRODUCT_H
