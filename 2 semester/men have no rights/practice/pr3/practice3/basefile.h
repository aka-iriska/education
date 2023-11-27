
#ifndef BASEFILE_H
#define BASEFILE_H
#include <QFile>
struct Spis{
    QString nam; QString pro, am, pr;
    Spis* p, *s;
};
struct Spisok{
    QString name; int k, allpr, count;//количество, сумма всех цен, количество производителей
                                     //(2 последних - ддля гистограммы и средней цены
    Spisok *p;
};
struct recType{
    QString name, prov, amount, price;
};
class baseFile
{
    QFile *f;
    bool k1,//в запросе присутствует фамилия
        k2,//в запросе присутствует имя
        k3,//найдена фамилия
        k4,//найдено имя
        ff;//найдена запись
public:
    recType r;
    baseFile();
    ~baseFile();
    bool addRec(recType r);
    bool delRec(recType r);
    bool readRec();
    bool findFirst(const recType r1);
    bool findNext(const recType r1);
    bool FromFirst();
};
#endif // BASEFILE_H
