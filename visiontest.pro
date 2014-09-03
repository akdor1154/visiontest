TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle

SOURCES += main.cpp
CONFIG += c++11

unix:!macx: LIBS += -lcvd -lGL

OTHER_FILES += \
    testimg.jpg

QMAKE_POST_LINK += cp $${PWD}/testimg.jpg $${OUT_PWD}
