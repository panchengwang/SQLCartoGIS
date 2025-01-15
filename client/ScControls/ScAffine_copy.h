#ifndef SCAFFINE_COPY_H
#define SCAFFINE_COPY_H

#include <QObject>
#include <QQmlEngine>
#include <ogr_geometry.h>
#include "ScAffineParameter.h"
#include <string>

class ScAffine : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScAffine(QObject *parent = nullptr);
    ScAffine(const ScAffine& other);

    void setParameters(double a, double b, double d, double e, double xoff, double yoff);
    // void setParameters(double a, double b, double c, double d, double e, double f, double g, double h, double i, double xoff, double yoff, double zoff);
    void setParameters(OGREnvelope& fromEv, OGREnvelope& toEv);
    OGRPoint* transform(OGRPoint* pt);
    OGRPoint transform(const OGRPoint& pt);

    void translate(double xoff, double yoff );
    void scale (double scaleX, double scaleY);
    void rotate(double angle);
    void rotateDegree(double degree);
    void reset();

    ScAffine inverted();

    ScAffine& operator=(const ScAffine& other);
protected:
    std::vector<ScAffineParameter> _parameters;
signals:

};

#endif // SCAFFINE_COPY_H
