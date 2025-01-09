#ifndef SCOGRPOINT_H
#define SCOGRPOINT_H

#include <QObject>
#include <QQmlEngine>
#include <ogr_geometry.h>


class ScOGRPoint : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double x READ x WRITE setX NOTIFY xChanged FINAL)
    Q_PROPERTY(double y READ y WRITE setY NOTIFY yChanged FINAL)
    QML_VALUE_TYPE(ScOGRPoint)
    // QML_ELEMENT
public:
    explicit ScOGRPoint(QObject *parent = nullptr);
    ScOGRPoint(const OGRPoint& ogrpt);
    ScOGRPoint(const ScOGRPoint& other);
    virtual ~ScOGRPoint();

    Q_INVOKABLE double x();
    Q_INVOKABLE void setX(double x);
    Q_INVOKABLE double y();
    Q_INVOKABLE void setY(double y);

    OGRPoint* getOGRPoint();

    Q_INVOKABLE QString toWKT();
    Q_INVOKABLE QString toString();
protected:
    OGRPoint _point;
signals:
    void xChanged();
    void yChanged();
};

#endif // SCOGRPOINT_H
