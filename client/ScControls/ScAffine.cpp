#include "ScAffine.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>

ScAffine::ScAffine(QObject *parent)
    : QObject{parent}
{
    reset();
}

ScAffine::ScAffine(const ScAffine& affine)
{
    _parameters = affine._parameters;
}

void ScAffine::setParameters(double a, double b, double d, double e, double xoff, double yoff)
{
    reset();
    _parameters.clear();
    ScAffineParameter param(a,b,d,e,xoff,yoff);
    _parameters.push_back(param);
}


void ScAffine::setParameters(OGREnvelope& fromEv, OGREnvelope& toEv){
    double sx = (toEv.MaxX - toEv.MinX) / (fromEv.MaxX - fromEv.MinX);
    double sy = (toEv.MaxY - toEv.MinY) / (fromEv.MaxY - fromEv.MinY);
    double scale = fabs(sx) < fabs(sy) ? fabs(sx) : fabs(sy);
    int xsign = sx > 0 ? 1 : -1;
    int ysign = sy > 0 ? 1 : -1;
    double xoff = (toEv.MinX + toEv.MaxX)*0.5 - (fromEv.MinX + fromEv.MaxX)*0.5*scale * xsign;
    double yoff = (toEv.MinY + toEv.MaxY)*0.5 - (fromEv.MinY + fromEv.MaxY)*0.5*scale * ysign;
    reset();
    this->scale(xsign*scale,ysign* scale);
    this->translate(xoff,yoff);
}


OGRPoint* ScAffine::transform(OGRPoint* pt){
    double x = pt->getX();
    double y = pt->getY();
    for(size_t i=0; i<_parameters.size(); i++){
        ScAffineParameter &param = _parameters.at(i);
        qDebug() << param.toString();
        double x1 = param._a * x + param._b * y + param._xoff;
        double y1 = param._d * x + param._e * y + param._yoff;
        x = x1;
        y = y1;
    }

    pt->setX(x);
    pt->setY(y);
    return pt;
}

OGRPoint ScAffine::transform(const OGRPoint& pt){
    double x = pt.getX();
    double y = pt.getY();
    for(size_t i=0; i<_parameters.size(); i++){
        ScAffineParameter &param = _parameters.at(i);
        double x1 = param._a * x + param._b * y + param._xoff;
        double y1 = param._d * x + param._e * y + param._yoff;
        x = x1;
        y = y1;
    }

    OGRPoint ret;
    ret.setX(x);
    ret.setY(y);
    return ret;
}

void ScAffine::translate(double xoff, double yoff){
    ScAffineParameter param;
    param._type = ScAffineParameter::OperatorType::TRANSLATE;
    param._xoff = xoff;
    param._yoff = yoff;
    _parameters.push_back(param);
}

void ScAffine::scale (double scaleX, double scaleY ){
    ScAffineParameter param;
    param._type = ScAffineParameter::OperatorType::SCALE;
    param._a = scaleX;
    param._e = scaleY;
    _parameters.push_back(param);
}

void ScAffine::rotate(double angle){
    qreal sina = 0;
    qreal cosa = 0;

    sina = sin(angle);               // fast and convenient
    cosa = cos(angle);

    ScAffineParameter param(cosa,sina,-sina,cosa,0,0);
    param._type = ScAffineParameter::OperatorType::ROTATE;
    _parameters.push_back(param);
}

void ScAffine::rotateDegree(double degree){
    qreal sina = 0;
    qreal cosa = 0;
    if (degree == 90. || degree == -270.)
        sina = 1.;
    else if (degree == 270. || degree == -90.)
        sina = -1.;
    else if (degree == 180.)
        cosa = -1.;
    else{
        double rad = degree/180.0*M_PI;
        sina = sin(rad);               // fast and convenient
        cosa = cos(rad);
    }

    ScAffineParameter param(cosa,sina,-sina,cosa,0,0);
    param._type = ScAffineParameter::OperatorType::ROTATE;
    _parameters.push_back(param);
}

void ScAffine::reset()
{
    _parameters.clear();

    ScAffineParameter param;
    _parameters.push_back(param);
}

ScAffine ScAffine::inverted()
{
    ScAffine invAffine;
    for(size_t i=_parameters.size()-1; i>=1; i--){
        ScAffineParameter param = _parameters.at(i);
        if(param._type == ScAffineParameter::OperatorType::TRANSLATE){
            param._xoff = -param._xoff;
            param._yoff = -param._yoff;
        }else if(param._type == ScAffineParameter::OperatorType::SCALE){
            param._a = 1.0 / param._a;
            param._e = 1.0 / param._e;
        }else if(param._type == ScAffineParameter::OperatorType::ROTATE){
            param._a = param._a;
            param._b = -param._b;
            param._d = -param._d;
            param._e = param._e;
        }
        invAffine._parameters.push_back(param);
        // qDebug() << param.toString();
    }
    return invAffine;
}


