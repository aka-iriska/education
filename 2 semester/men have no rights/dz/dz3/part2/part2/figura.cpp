
#include "figura.h"
#include <math.h>
void Figura::move(float Alpha,QPainter *Painter, double n, int width)//int t, int n
{
    if (((x+dx+halflen>width-0.5*n) && (f==1)) ||((x+dx-halflen<0.5*n) && (f==-1))){ //0.5*10*3(n)
        if (k==1){t2=Alpha-t2; k=2;}
        if (f==1) tt=t2;
        f=-f;}
    if (f==1)tt=tt+0.5*n;
    else tt=tt-0.5*n;
    dx=round(tt);
    draw(Painter);
}
void MyRomb::draw(QPainter *Painter)
{
    Painter->drawLine(x+dx+halflen, y,x+dx,y+2*halflen);
    Painter->drawLine(x+dx,y+2*halflen, x+dx-halflen,y);
    Painter->drawLine(x+dx-halflen,y, x+dx,y-2*halflen);
    Painter->drawLine(x+dx,y-2*halflen, x+dx+halflen,y);
}
void MySquare::draw(QPainter *Painter)
{
    Painter->drawLine(x+dx+halflen, y+halflen,x+dx-halflen,y+halflen);
    Painter->drawLine(x+dx-halflen,y+halflen,x+dx-halflen,y-halflen);
    Painter->drawLine(x+dx-halflen,y-halflen,x+dx+halflen,y-halflen);
    Painter->drawLine(x+dx+halflen,y-halflen,x+dx+halflen,y+halflen);
}
void MyRRomb::draw(QPainter*Painter){
    int a, b;
    a=halflen/3;
    Painter->drawLine(x+dx+a, y,x+dx,y+2*a);
    Painter->drawLine(x+dx,y+2*a,x+dx-a,y);
    Painter->drawLine(x+dx-a,y,x+dx,y-2*a);
    Painter->drawLine(x+dx,y-2*a,x+dx+a,y);
    b=halflen/2;
    Painter->drawLine(x+dx+halflen, y, x+dx,y+b);
    Painter->drawLine(x+dx,y+b, x+dx-halflen,y);
    Painter->drawLine(x+dx-halflen,y, x+dx,y-b);
    Painter->drawLine(x+dx,y-b, x+dx+halflen,y);
}
