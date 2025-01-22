#ifndef SCPROJECTION_H
#define SCPROJECTION_H

#include <QObject>
#include <QQmlEngine>
#include <ogr_api.h>
#include <ogr_geometry.h>

class ScProjection : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScProjection(QObject *parent = nullptr);

    static bool transform(OGRPoint* pt, int srcSrid, int targetSrid);

};

#endif // SCPROJECTION_H
