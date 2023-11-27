
#ifndef FIGURA_H
#define FIGURA_H

#include <QtGui>
class Figura
{
protected:
    int x,y,halflen,dx,f, k;float t2, tt;
    virtual void draw(QPainter *Painter)=0;
public:
    Figura(int X,int Y,int Halflen):
        x(X),y(Y),halflen(Halflen){t2=0; tt=0; f=1; k=1;}
    void move(float Alpha,QPainter *Painter, double n, int width);
    virtual ~Figura(){};
};
class MyRomb:public Figura
{
protected:
    void draw(QPainter *Painter) override;
public:
    MyRomb(int x,int y,int halflen):Figura(x,y,halflen){}
};
class MySquare:public Figura
{
protected:
    void draw(QPainter *Painter) override;
public:
    MySquare(int x,int y,int halflen):Figura(x,y,halflen){}
};
class MyRRomb:public Figura
{
protected:
    void draw(QPainter *Painter) override;
public:
    MyRRomb(int x,int y,int halflen):Figura(x,y,halflen){}
};
#endif // FIGURA_H
