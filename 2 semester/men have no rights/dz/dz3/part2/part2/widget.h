
#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QtGui>
#include <QPushButton>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include "area.h"
class Window : public QWidget
{
protected:
    Area * area;         // область отображения рисунка
    QPushButton * btn;
public:
    Window();
};

#endif // WIDGET_H
