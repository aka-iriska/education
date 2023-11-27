/********************************************************************************
** Form generated from reading UI file 'strdialog.ui'
**
** Created by: Qt User Interface Compiler version 6.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_STRDIALOG_H
#define UI_STRDIALOG_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>

QT_BEGIN_NAMESPACE

class Ui_strDialog
{
public:

    void setupUi(QDialog *strDialog)
    {
        if (strDialog->objectName().isEmpty())
            strDialog->setObjectName("strDialog");
        strDialog->resize(800, 600);

        retranslateUi(strDialog);

        QMetaObject::connectSlotsByName(strDialog);
    } // setupUi

    void retranslateUi(QDialog *strDialog)
    {
        strDialog->setWindowTitle(QCoreApplication::translate("strDialog", "\320\237\321\200\320\265\320\276\320\261\321\200\320\260\320\267\320\276\320\262\320\260\320\275\320\270\320\265 \321\201\321\202\321\200\320\276\320\272\320\270", nullptr));
    } // retranslateUi

};

namespace Ui {
    class strDialog: public Ui_strDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_STRDIALOG_H
