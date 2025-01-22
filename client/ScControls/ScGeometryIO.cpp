#include "ScGeometryIO.h"


ScGeometryIO::ScGeometryIO(QObject *parent)
    : QObject{parent}
{

}

QString ScGeometryIO::toWKB(OGRGeometry* geo)
{
    size_t len = geo->WkbSize();
    unsigned char* buf = new unsigned char[len];
    geo->exportToWkb(buf);
    QByteArray wkb((const char*)buf, len);
    delete [] buf;
    return QString(wkb.toHex());
}

OGRGeometry* ScGeometryIO::fromWKB(const QString& wkb)
{
    QByteArray buf = QByteArray::fromHex(wkb.toLocal8Bit());
    OGRGeometry* geo ;
    OGRGeometryFactory::createFromWkb(buf.data(),NULL,&geo);
    return geo;
}

QString ScGeometryIO::toWKT(OGRGeometry* geo)
{
    char* buf;
    geo->exportToWkt(&buf);
    QString ret(buf);
    CPLFree(buf);
    delete [] buf;
    return ret;
}

OGRGeometry* ScGeometryIO::fromWKT(const QString& wkt)
{
    return NULL;
}
