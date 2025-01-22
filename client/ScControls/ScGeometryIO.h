#ifndef SCGEOMETRYIO_H
#define SCGEOMETRYIO_H

#include <QObject>
#include <QQmlEngine>
#include <ogr_geometry.h>

class ScGeometryIO : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScGeometryIO(QObject *parent = nullptr);

    QString toWKB(OGRGeometry* geo);
    OGRGeometry* fromWKB(const QString& wkb);

    QString toWKT(OGRGeometry* geo);
    OGRGeometry* fromWKT(const QString& wkt);

signals:

};

#endif // SCGEOMETRYIO_H
