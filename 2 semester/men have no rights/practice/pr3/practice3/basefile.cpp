
#include "basefile.h"
#include <QMessageBox>

baseFile::baseFile()
{
    f=new QFile("base.txt");
    if(!f->exists()) // если файл не существует, то
    {      // формирмируем сообщение
        QMessageBox msg(QMessageBox::Critical, "Файл не найден",
                        "Файл base.txt не создан",
                        QMessageBox::Ok,0);
        msg.exec();// выводим сообщение на экран
    }
    f->open(QFile::ReadWrite); // открываем файл для ввода-вывода
}
baseFile::~baseFile()   // деструктор
{
    f->close();        // закрываем файл
    delete f;                        // освобождаем память под указатель
}
bool baseFile::addRec(recType r)
{
    f->seek(f->size()); // переходим на конец файла
    QDataStream out(f); // связываем с файлом поток вывода
    out<<r.name<<r.prov<<r.amount<<r.price;// выводим данные в файл
    return true;
}
bool baseFile::delRec(recType r1){
    f->seek(0);
    QFile* f1=new QFile("trash.txt");
    f1->open(QFile::ReadWrite);
    k1=(r1.name=="");   // устанавливаем два ключа поиска, присутствует имя
    k2=(r1.prov=="");//присутсвует фамилия
    f->reset();
    f1->reset();
    bool fff = FromFirst();
    while(fff)
    {
        k3=(r1.name==r.name);  //строим еще два ключа поиска
        k4=(r1.prov==r.prov);
        QDataStream out1(f1);
        if ((!k1 && !k2 && (!k3 || !k4))||
            (!k1 && k2 && !k3)||
            (k1 && !k2 && !k4)){
            out1<<r.name<<r.prov<<r.amount<<r.price;
        }
        fff=readRec();
    }
    f->resize(0);
    f1->reset();
    fff=true;
    while (fff){
        QDataStream in1(f1); // связываем с файлом поток ввода
        if (in1.atEnd()||r.name=="")fff=false;
        else
        {
        in1>>r.name>>r.prov>>r.amount>>r.price;
        addRec(r);
        }
    }
    f1->resize(0);
    f1->close();
    delete f1;
    return true;
}
bool baseFile::readRec()//для таблицы
{
    QDataStream in(f); // связываем с файлом поток ввода
    if (in.atEnd())return false;
    else
    {
        in>>r.name>>r.prov>>r.amount>>r.price;
        return true;
    }
}
bool baseFile::findFirst(const recType r1)//первое совпадение
{
    k1=(r1.name=="");   // устанавливаем два ключа поиска, присутствует имя
    k2=(r1.prov=="");//присутсвует фамилия
    ff=false;   // устанавливаем ключ поиска «запись не найдена»
    f->reset();
    bool fff = readRec();
    while(fff &&(!ff))
    {
        k3=(r1.name==r.name);  //строим еще два ключа поиска
        k4=(r1.prov==r.prov);
        if ((!k1 && !k2 && k3 && k4)||
            (!k1 && k2 && k3)||//найдено имя
            (k1 && !k2 && k4)) //найдена фамилия
            ff=true; // ключ поиска «запись найдена»
        else fff=readRec();
    }
    return ff; // возвращаем ключ поиска
}
bool baseFile::findNext(const recType r1)
{
    ff=false;   // ключ поиска «запись не найдена»
    bool fff = readRec();
    while((!ff) && fff)
    {
        k3=(r1.name==r.name);//строим еще два ключа поиска
        k4=(r1.prov==r.prov);
        if ((!k1 && !k2 && k3 && k4)|| //если имя и пров. не пустые и они равны нужному
            (!k1 && k2 && k3)||
            (k1 && !k2 && k4))
            ff=true;     // ключ поиска «запись найдена»
        else fff=readRec();
    }
    return ff; // возвращаем ключ поиска
}
bool baseFile::FromFirst(){
    bool ff;
    f->seek(0);
    ff=readRec();
    return ff;
}


