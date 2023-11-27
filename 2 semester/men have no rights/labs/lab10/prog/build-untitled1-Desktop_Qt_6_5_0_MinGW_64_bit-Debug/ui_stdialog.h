/********************************************************************************
** Form generated from reading UI file 'stdialog.ui'
**
** Created by: Qt User Interface Compiler version 6.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_STDIALOG_H
#define UI_STDIALOG_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>

QT_BEGIN_NAMESPACE

class Ui_stDialog
{
public:

    void setupUi(QDialog *stDialog)
    {
        if (stDialog->objectName().isEmpty())
            stDialog->setObjectName("stDialog");
        stDialog->resize(800, 600);

        retranslateUi(stDialog);

        QMetaObject::connectSlotsByName(stDialog);
    } // setupUi

    void retranslateUi(QDialog *stDialog)
    {
        stDialog->setWindowTitle(QCoreApplication::translate("stDialog", "stDialog", nullptr));
    } // retranslateUi

};

namespace Ui {
    class stDialog: public Ui_stDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_STDIALOG_H
