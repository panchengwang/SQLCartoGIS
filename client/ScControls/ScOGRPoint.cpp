#include "ScOGRPoint.h"


ScOGRPoint::ScOGRPoint(QObject *parent)
    : QObject{parent}
{
    _point = OGRPoint(0,0);
}

ScOGRPoint::ScOGRPoint(const OGRPoint& ogrpt)
{
    _point = ogrpt;
}

ScOGRPoint::ScOGRPoint(const ScOGRPoint& other)
{
    _point = other._point;
}

ScOGRPoint::~ScOGRPoint()
{

}

double ScOGRPoint::x()
{
    return _point.getX();
}

void ScOGRPoint::setX(double x)
{
    _point.setX(x);
}

double ScOGRPoint::y()
{
    return _point.getX();
}

void ScOGRPoint::setY(double y)
{
    _point.setY(y);
}

OGRPoint* ScOGRPoint::getOGRPoint()
{
    return &_point;
}

QString ScOGRPoint::toWKT()
{
    char *ppszDstText;
    _point.exportToWkt(&ppszDstText);

    QString wkt(ppszDstText);
    CPLFree(ppszDstText);
    return wkt;
}

QString ScOGRPoint::toString()
{
    return toWKT();
}
