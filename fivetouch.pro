QT        += core gui network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport

TARGET    =  fivetouch
TEMPLATE  =  app

SOURCES   += main.cpp \
    fivetouch.c  

HEADERS   += \   
    fivetouch.prg
FORMS     += 
RESOURCES += 

CONFIG    += mobility
MOBILITY  = 

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += $$PWD/android/AndroidManifest.xml

INCLUDEPATH += C:/harbour/include/

LIBS += -LC:\harbour\lib\android\gccarm -LC:\harbour\contrib\lib\android\gccarm  \
           -Wl,--start-group      \
                -lhbamf \
                -lhbblink \
                -lhbbz2 \
                -lhbcomio \
                -lhbcomm \
                -lhbrtl \
                -lhbct \
                -lhbextern \
                -lhbformat \
                -lhbfoxpro \
                -lhbgt \
                -lhbhpdf \
                -lhbhttpd \
                -lhblzf \
                -lhbmisc \
                -lhbmlzo \
                -lhbmxml \
                -lhbnetio \
                -lhbnf \
                -lhboslib \
                -lhbsms \
                -lhbsqlit3 \
                -lhbtcpio \
                -lhbtest \
                -lhbtinymt \
                -lhbtpathy \
                -lhbvm \
                -lhbxdiff \
                -lhbzebra \
                -lhbziparc \
                -lrddbm \
                -lsddsqlt3 \
                -lxhb \
                -lbz2 \
                -lhbformat \
                -llibhpdf \
                -llzf \
                -lminilzo \
                -lmxml \
                -lhbexpat \
                -lhbmemio \
                -lhbnetio \
                #-lhbssl \
                -lhbunix \
                -ltinymt \
                -lxdiff \
                -lhbmzip \
                -lrddsql \
                -lsqlite3 \
                -lhbct \
                -lhbtip \
                -lhbfship \
                -lhbxpp \
                -lexpat \
                -lminizip \
                -lhbdebug \
                -lhbextern \
                -lhbuddall \
                -lhbusrrdd \
                -lhbhsx \
                -lhbsix \
                -lrddfpt \
                -lrddcdx \
                -lrddnsx \
                -lrddntx \
                -lhbrdd \
                -lhblang \
                -lhbcpage \
                -lhbmacro \
                -lgttrm \
                -lhbcplr \
                -lhbpp \
                -lhbcommon \
                -lhbzlib \
                -ltiff \
                -lhbpcre \
                -ljpeg \
                -lpng \
                #-lgtnet \
                #-ldbrmap \
                -lhbqtwidgets \
                #-lhbqtzxing \
                -lhbqtsensors \
                -lhbqtquick \
                -lhbqtqml \
                -lhbqtbluetooth \
                -lhbqtwebsockets \
                -lhbqtpositioning \
                -lhbqtxml \
                -lhbqtsvg \
                -lhbqtsql \
                -lhbqtscript \
                -lhbqtopengl \
                -lhbqtmultimediawidgets \
                -lhbqtmultimedia \
                -lhbqtdeclarative \
                -lhbqtnetwork \
                -lhbqtgui \
                -lhbqtcore \
                -lhbxbp \
                #-lqscintilla2 \
                #-lhbqscintilla \
           -Wl,--end-group

 COMMON_DATA.path = /assets
 COMMON_DATA.files = $$files($$PWD/samples/*)
 INSTALLS += COMMON_DATA

DISTFILES += \
    test.prg