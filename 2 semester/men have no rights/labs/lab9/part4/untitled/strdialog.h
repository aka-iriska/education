
#ifndef STRDIALOG_H
#define STRDIALOG_H

#include <QDialog>
#include <QLineEdit>
#include <QPushButton>
#include <QTextEdit>

class strDialog : public QDialog

{
    Q_OBJECT

public:
    strDialog(QWidget *parent = nullptr);
    virtual~strDialog(){};

protected:
    QLineEdit* Edit;
    QPushButton* Button;
    QPushButton* Exit;
    QTextEdit* Text;
    QString getEdit();
private slots:
    /// Слот для обработки нажатий всех кнопок
    void clicked();
};

#endif // STRDIALOG_H
