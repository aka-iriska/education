/********************************************************************************
** Form generated from reading UI file 'calcdialog.ui'
**
** Created by: Qt User Interface Compiler version 6.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_CALCDIALOG_H
#define UI_CALCDIALOG_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>

QT_BEGIN_NAMESPACE

class Ui_CalcDialog
{
public:

    void setupUi(QDialog *CalcDialog)
    {
        if (CalcDialog->objectName().isEmpty())
            CalcDialog->setObjectName("CalcDialog");
        CalcDialog->resize(800, 600);

        retranslateUi(CalcDialog);

        QMetaObject::connectSlotsByName(CalcDialog);
    } // setupUi

    void retranslateUi(QDialog *CalcDialog)
    {
        CalcDialog->setWindowTitle(QCoreApplication::translate("CalcDialog", "CalcDialog", nullptr));
    } // retranslateUi

};

namespace Ui {
    class CalcDialog: public Ui_CalcDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_CALCDIALOG_H
