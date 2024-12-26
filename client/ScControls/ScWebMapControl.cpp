#include "ScWebMapControl.h"
#include <QtCore>
#include <QtGui>

ScWebMapControl::ScWebMapControl(QQuickItem* parent)
{
    _z = 14;
    // _center.setX(12574067);
    // _center.setY(3270359);

    // connect(this,SIGNAL(windowChanged(QQuickWindow*)), this,SLOT(onWindowChanged(QQuickWindow*)));
}

ScWebMapControl::~ScWebMapControl()
{

}

void ScWebMapControl::paint(QPainter* painter)
{
    qDebug() << "paint";

}

int ScWebMapControl::z() const
{
    return _z;
}

void ScWebMapControl::setZ(int z)
{
    _z = z;
}

double ScWebMapControl::getResolutionOfZ(int z)
{
    return _resolutions[z];
}




