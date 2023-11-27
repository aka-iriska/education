
#ifndef THEMOSTFORM_H
#define THEMOSTFORM_H

#include <QWidget>
#include <QObject>
#include <basefile.h>

#include <QPushButton>
#include <QLineEdit>

class themostForm:public QWidget
{
    Q_OBJECT//!!!!!работает с сигналами и слотами
    QPushButton* countbtn;
    QPushButton* exitbtn;
    QLineEdit* resulte;
public:
    themostForm();
public slots:
    void prCount();
};

#endif // THEMOSTFORM_H
