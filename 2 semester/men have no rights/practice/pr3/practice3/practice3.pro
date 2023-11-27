QT       += core gui
QT+=charts
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    gystform.cpp \
    main.cpp \
    mainform.cpp \
    basefile.cpp \
    themostform.cpp \
    muchform.cpp \
    benproform.cpp \
    tableform.cpp

HEADERS += \
    gystform.h \
    mainform.h \
    basefile.h \
    themostform.h \
    muchform.h \
    benproform.h \
    tableform.h

FORMS += \
    mainform.ui

TRANSLATIONS += \
    practice3_ru_RU.ts
CONFIG += lrelease
CONFIG += embed_translations

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
