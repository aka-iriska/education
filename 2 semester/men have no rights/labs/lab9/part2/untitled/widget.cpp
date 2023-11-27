
#include "widget.h"
#include "ui_widget.h"
#include <QMessageBox>
// Преобразуем входную последовательность символов в кодировку UNICODE

Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);
    connect(ui->pushButton, SIGNAL(clicked()), this, SLOT(on_pushButton_clicked()));
}

Widget::~Widget()
{
    delete ui;
}

void Widget::on_pushButton_clicked()
{
    if( QMessageBox::question ( this, QString(), "Close the app?", QMessageBox::Yes|QMessageBox::No) == QMessageBox::Yes ) exit(0);
    else show();
}

