
#ifndef AREA_H
#define AREA_H
#include <QWidget>
#include "figura.h"
class Area : public QWidget
{
    int myTimer; // идентификатор таймера
    int width;
    float alpha; // "таймер"
public:
    Area(QWidget *parent = 0);
    ~Area();
    MyRomb *myromb;
    MySquare *mysquare;
    MyRRomb *myrromb;
protected:
    //	обработчики событий
    void paintEvent(QPaintEvent *event);
    void timerEvent(QTimerEvent *event);
    void showEvent(QShowEvent *event);
    void hideEvent(QHideEvent *event);
};

#endif // AREA_H
