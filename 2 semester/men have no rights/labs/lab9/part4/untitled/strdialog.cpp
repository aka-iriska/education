
#include "strdialog.h"
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QDebug>

strDialog::strDialog(QWidget *parent)
{
    this->setWindowTitle("Преобразование строки");
    Edit= new QLineEdit;
    Button=new QPushButton;
    Exit=new QPushButton;
    Text= new QTextEdit;
    Button->setText("Преобразовать");
    Exit->setText("Выйти");
    Text->setReadOnly(true);
    QVBoxLayout *layout = new QVBoxLayout();
    layout->addWidget(Edit);
    layout->addWidget(Button);
    layout->addWidget(Text);
    layout->addWidget(Exit);
    setLayout(layout);
    connect(Button, SIGNAL (clicked()), this, SLOT (clicked()));
    connect(Exit, SIGNAL(clicked()), this, SLOT(close()));
};
void strDialog::clicked(){
    Text->clear();
    QString out = getEdit();
    Text->append("input: "+out);
    Text->append("all lower: " + out.toLower());
    Text->append("ALL UPPER: "+ out.toUpper());
};
QString strDialog::getEdit(){
    return Edit->text();
};
