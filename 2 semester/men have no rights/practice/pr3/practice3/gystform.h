
#ifndef GYSTFORM_H
#define GYSTFORM_H


#include <QObject>
#include <QWidget>
#include <QPushButton>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>

#include "basefile.h"

#include <QtCharts/QtCharts>
class gystForm:public QWidget
{
    Q_OBJECT
    QPushButton* exitbtn;
    QPushButton* printbtn;
    QChart* Gystog;
    QChartView* chartview;
    QBarSeries *series;
    QValueAxis *axisY;
    QBarCategoryAxis *axisX;
    QBarSet*srpr;
    QStringList categories;//имена продуктов
public:
    gystForm();
public slots:
    void printGyst();
    //void closeform();
};

#endif // GYSTFORM_H
