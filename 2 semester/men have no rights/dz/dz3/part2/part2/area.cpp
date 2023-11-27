#include "area.h"
Area::Area(QWidget *parent):QWidget(parent)
{
    width=300;
    setFixedSize(QSize(width,500));
    mysquare=new MySquare(100,60,50);
    myromb = new MyRomb(150,197,40);
    myrromb=new MyRRomb(200, 350, 100);
    alpha=0;
}
void Area::showEvent(QShowEvent *)
{
    myTimer=startTimer(50);           // создать таймер
}
void Area::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    painter.setPen(Qt::red);
    double v1=15; double v2=9; double v3=7.5;//скорости
    mysquare->move(alpha*v1,&painter, v1, width);
    myromb->move(alpha*v2,&painter, v2, width);
    myrromb->move(alpha*v3, &painter, v3, width);
}
void Area::timerEvent(QTimerEvent *event)
{
    if (event->timerId() == myTimer) // если наш таймер
    {
        alpha=alpha+0.5;
        update();                     // обновить внешний вид
    }
    else
        QWidget::timerEvent(event);   // иначе передать для стандартной
            // обработки
}
void Area::hideEvent(QHideEvent *)
{
    killTimer(myTimer);             // уничтожить таймер
}
Area::~Area()
{
    delete mysquare;
    delete myromb;
    delete myrromb;
}
