/********************************************************************************
** Form generated from reading UI file 'mainform.ui'
**
** Created by: Qt User Interface Compiler version 6.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINFORM_H
#define UI_MAINFORM_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_mainForm
{
public:
    QLabel *label;
    QPushButton *pushButton;

    void setupUi(QWidget *mainForm)
    {
        if (mainForm->objectName().isEmpty())
            mainForm->setObjectName("mainForm");
        mainForm->resize(800, 600);
        label = new QLabel(mainForm);
        label->setObjectName("label");
        label->setGeometry(QRect(50, 390, 49, 16));
        pushButton = new QPushButton(mainForm);
        pushButton->setObjectName("pushButton");
        pushButton->setGeometry(QRect(230, 270, 80, 24));

        retranslateUi(mainForm);

        QMetaObject::connectSlotsByName(mainForm);
    } // setupUi

    void retranslateUi(QWidget *mainForm)
    {
        mainForm->setWindowTitle(QCoreApplication::translate("mainForm", "mainForm", nullptr));
        label->setText(QCoreApplication::translate("mainForm", "TextLabel", nullptr));
        pushButton->setText(QCoreApplication::translate("mainForm", "PushButton", nullptr));
    } // retranslateUi

};

namespace Ui {
    class mainForm: public Ui_mainForm {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINFORM_H
