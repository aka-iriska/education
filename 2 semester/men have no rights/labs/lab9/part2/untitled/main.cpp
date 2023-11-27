
#include "widget.h"
#include <QApplication>
#include <QSplitter>


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    //Widget w;
    //w.show();
    // Отображаем две формы горизонтально с вертикальным разделителем
    QSplitter * splitter = new QSplitter(Qt::Vertical);
    Widget * dialog1 = new Widget();
    Widget * dialog2 = new Widget();
    splitter->addWidget( dialog1 );
    splitter->addWidget( dialog2 );
    splitter->show(); // отображаем окно
    return a.exec();
}
