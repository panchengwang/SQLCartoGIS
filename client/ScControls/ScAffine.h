#ifndef SCAFFINE_H
#define SCAFFINE_H

#include <QObject>
#include <QQmlEngine>
#include <ogr_geometry.h>

typedef struct{
    double a,b,c,d,e,f,g,h,i,xoff,yoff,zoff;
}AffineParameters;

class ScAffine : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScAffine(QObject *parent = nullptr);


    // void setParameters(double a, double b, double d, double e, double xoff, double yoff);
    // void setParameters(double a, double b, double c, double d, double e, double f, double g, double h, double i, double xoff, double yoff, double zoff);
    void setParameters(OGREnvelope& fromEv, OGREnvelope& toEv);
    OGRPoint* transform(OGRPoint* pt);
    OGRPoint transform(const OGRPoint& pt);

    void translate(double xoff, double yoff, double zoff=0);
    void scale (double scaleX, double scaleY, double scaleZ = 1.0);
    void rotate(double angle);
    void rotateDegree(double degree);
    void reset();
protected:
    // double _a,_b,_c,_d,_e,_f, _g, _h, _i, _xoff,_yoff,_zoff;
    // double _scaleX,_scaleY,_scaleZ;

    std::vector<AffineParameters> _parameters;
signals:

};

#endif // SCAFFINE_H
