QT += core gui network widgets printsupport

CONFIG -= bitcode

TARGET = fivetouch
TEMPLATE = app

QMAKE_IOS_DEPLOYMENT_TARGET=8

SOURCES += ../main.cpp

PRGS = ../prgs/fivetouch.prg \
       ../prgs/extend.prg \
       ../prgs/files.prg \
       ../prgs/function.prg \
       ../prgs/ide.prg \
       ../prgs/link.prg \
       ../prgs/msgs.prg \
       ../prgs/run.prg \
       ../prgs/system.prg \
       ../prgs/themes.prg

OTHER_FILES += $$PRGS

HARBOUR_INCLUDE = /Users/${USER}/harbour/include
QMAKE_CFLAGS += -I$$HARBOUR_INCLUDE
INCLUDEPATH += $$HARBOUR_INCLUDE

harbour.output  = ${QMAKE_FILE_BASE}.c
harbour.commands = ~/harbour/bin/harbour ${QMAKE_FILE_NAME} -n -I$$PWD/.. -DFROM_OSX -I$$HARBOUR_INCLUDE -o${QMAKE_FILE_OUT}
harbour.variable_out = SOURCES
harbour.input = PRGS
QMAKE_EXTRA_COMPILERS += harbour

LIBS += -L~/harbour/lib/ios \
           -Wl, \
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
                -lhbmemio \
                -lhbnetio \
                -lhbssl \
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
                -lhbpcre \
                -lhbqtwidgets \
                -lhbqtsensors \
                -lhbqtqml \
                -lhbqtwebsockets \
                -lhbqtpositioning \
                -lhbqtxml \
                -lhbqtsvg \
                -lhbqtsql \
                -lhbqtscript \
                -lhbqtmultimediawidgets \
                -lhbqtmultimedia \
                -lhbqtnetwork \
                -lhbqtgui \
                -lhbqtcore \
                -lhbxbp \
                -lqscintilla2 \
                -lhbqscintilla \
           -Wl

ios
{
   sampleFiles.files = $$PWD/../samples/tutor02.prg \
                       $$PWD/../samples/browse.prg  \
                       $$PWD/../samples/toolbar.prg
   sampleFiles.path = .
   QMAKE_BUNDLE_DATA += sampleFiles

   headerFiles.files = ../FiveTouch.ch \
                       /Users/${USER}/harbour/include/hbclass.ch \
                       /Users/${USER}/harbour/include/hboo.ch
   headerFiles.path = /include
   QMAKE_BUNDLE_DATA += headerFiles

   imageFiles.files = ../images/cancel.png \
                      ../images/plus.png
   imageFiles.path = /images
   QMAKE_BUNDLE_DATA += imageFiles
}
