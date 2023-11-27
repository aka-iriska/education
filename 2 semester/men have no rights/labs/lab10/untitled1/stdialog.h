
#ifndef STDIALOG_H
#define STDIALOG_H

#include <QDialog>
#include <QLineEdit>
#include <QPushButton>
#include <QTextEdit>
#include <QRadioButton>
#include<QLabel>
class stDialog : public QDialog

{    Q_OBJECT
public:
    stDialog(QWidget *parent = nullptr);
    ~stDialog(){};
protected:
    QLineEdit* Edit;
    QLineEdit* s;
    QLabel* slabel;
    QPushButton* addb;
    QPushButton* delb;
    QRadioButton* st;//стек или очередь
    QRadioButton* ord;
    QPushButton* Exit;
    QTextEdit* Text;
    QString getEdit();
private slots:
    /// Слот для обработки нажатий всех кнопок
    void clicked();
    void clicked1();
};

#endif // STDIALOG_H
