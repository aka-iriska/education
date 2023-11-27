
#include "gystform.h"
gystForm::gystForm()
{
    this->setWindowTitle("Гистограмма");
    exitbtn=new QPushButton("Меню");
    printbtn=new QPushButton("Вывести");
    Gystog=new QChart();
    chartview = new QChartView(Gystog);
    axisY= new QValueAxis();
    axisX= new QBarCategoryAxis();
    series= new QBarSeries();
    srpr=new QBarSet("Средняя цена");
    QHBoxLayout* layout=new QHBoxLayout();
    layout->addWidget(printbtn);
    layout->addWidget(exitbtn);
    QVBoxLayout*layout1=new QVBoxLayout();
    layout1->addWidget(chartview);
    layout1->addLayout(layout);
    setLayout(layout1);
    resize(600, 400);
    connect(exitbtn, SIGNAL(clicked(bool)), this, SLOT(close()));
    connect(printbtn, SIGNAL(clicked(bool)), this, SLOT(printGyst()));
}
void gystForm::printGyst(){
    baseFile base;float max=0;
    srpr->remove(0, categories.size());
    axisX->clear();
    categories.resize(0);
    bool fff = base.FromFirst();
    if (fff==false) {QMessageBox msg(QMessageBox::Critical, "Файл не найден",
                        "Файл base.txt не создан",
                        QMessageBox::Ok,0);
        msg.exec();
    }
    else {
        Spisok *first=new Spisok;
        first->name=base.r.name;
        QString str=base.r.amount;
        //first->k=str.toInt();
        first->allpr=base.r.price.toInt();
        first->count=1;
        first->p=nullptr;
        Spisok*r, *r1;
        while (fff=base.readRec(), str=base.r.amount, fff){
        r=first;
        bool find=false;
        while (r!=nullptr&&find==false){
            if (base.r.name==r->name) {
                //r->k+=str.toInt();
                r->allpr+=base.r.price.toInt();
                r->count+=1;
                find=true;}
            else{
                if(r->p!=nullptr)r=r->p;
                else{
                    r1=new Spisok;
                    r1->name=base.r.name;
                    //r1->k=str.toInt();
                    r1->allpr=base.r.price.toInt();
                    r1->count=1;
                    r1->p=nullptr;
                    r->p=r1;
                    r=r1;
                    find=true;
                }
            }
        }
        }
        r=first;r1=first;
        while (r!=nullptr){
            srpr->append(r->allpr/r->count);
            categories<<r->name;
            if (r->allpr/r->count>max) max=r->allpr/r->count;
            r=r->p;
            delete r1;
            r1=r;
        }
    }
    series->append(srpr);
    //-
    Gystog->addSeries(series);
    //про y
    axisY->setRange(0,max);
    Gystog->addAxis(axisY, Qt::AlignLeft);
    series->attachAxis(axisY);
    //про x
    axisX->append(categories);
    Gystog->addAxis(axisX, Qt::AlignBottom);
    series->attachAxis(axisX);
    //--
    Gystog->legend()->setVisible(true);
    Gystog->legend()->setAlignment(Qt::AlignBottom);
    chartview->setRenderHint(QPainter::Antialiasing);
}
