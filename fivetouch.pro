QT        += core gui network widgets printsupport

TARGET    =  fivetouch
TEMPLATE  =  app

SOURCES   += main.cpp

PRGS = .\source\fivetouch.prg \
       .\source\buildch.prg \
       .\source\extend.prg \
       .\source\files.prg \
       .\source\function.prg \
       .\source\ide.prg \
       .\source\msgs.prg \
       .\source\run.prg \
       .\source\system.prg

OTHER_FILES += $$PRGS

HARBOUR_INCLUDE = c:/harbour/include
QMAKE_CFLAGS += -I$$HARBOUR_INCLUDE
INCLUDEPATH += $$HARBOUR_INCLUDE

harbour.output  = $$PWD/${QMAKE_FILE_BASE}.c
harbour.commands = c:\harbour\bin\harbour ${QMAKE_FILE_NAME} -n -I$$PWD -I$$HARBOUR_INCLUDE -o${QMAKE_FILE_OUT}
harbour.variable_out = SOURCES
harbour.input = PRGS
QMAKE_EXTRA_COMPILERS += harbour

CONFIG    += mobility

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += $$PWD/android/AndroidManifest.xml

LIBS += -LC:\harbour\lib\android  \
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
                -lgtnet \
                -ldbrmap \
                -lhbqtwidgets \
                -lhbqtzxing \
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
                -lqscintilla2 \
                -lhbqscintilla \
           -Wl,--end-group

 COMMON_DATA.path = /assets
 COMMON_DATA.files = $$files($$PWD/samples/*)
 INSTALLS += COMMON_DATA
