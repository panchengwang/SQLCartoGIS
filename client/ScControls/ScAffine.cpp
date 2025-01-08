#include "ScAffine.h"
#include <math.h>

ScAffine::ScAffine(QObject *parent)
    : QObject{parent}
{
reset();
}

// void ScAffine::setParameters(double a, double b, double d, double e, double xoff, double yoff)
// {
//     _a = a;
//     _b = b;
//     _c = 0;
//     _d = d;
//     _e = e;
//     _f = 0;
//     _g = 0;
//     _h = 0;
//     _i = 0;
//     _xoff = xoff;
//     _yoff = yoff;
//     _zoff = 0;
// }

// void ScAffine::setParameters(double a, double b, double c, double d, double e, double f, double g, double h, double i, double xoff, double yoff, double zoff)
// {
//     _a = a;
//     _b = b;
//     _c = c;
//     _d = d;
//     _e = e;
//     _f = f;
//     _g = g;
//     _h = h;
//     _i = i;
//     _xoff = xoff;
//     _yoff = yoff;
//     _zoff = zoff;
// }

// void ScAffine::setParameters(OGREnvelope& fromEv, OGREnvelope& toEv)
// {
//     double sx =fabs( (toEv.MaxX - toEv.MinX) / (fromEv.MaxX - fromEv.MinX));
//     double sy = fabs((toEv.MaxY - toEv.MinY) / (fromEv.MaxY - fromEv.MinY));
//     double scale = sx < sy ? sx : sy;
//     double xoff = (toEv.MinX + toEv.MaxX)*0.5 - (fromEv.MinX + fromEv.MaxX)*0.5;
//     double yoff = (toEv.MinY + toEv.MaxY)*0.5 - (fromEv.MinY + fromEv.MaxY)*0.5;
//     reset();

//     this->scale(scale,scale);
//       this->translate(xoff,yoff);
// }

// OGRPoint* ScAffine::transform(OGRPoint* pt)
// {
//     double x = _a * pt->getX() + _b * pt->getY() + _c * pt->getZ() + _xoff;
//     double y = _d * pt->getX() + _e * pt->getY() + _f * pt->getZ() + _yoff;
//     double z = _g * pt->getY() + _h * pt->getY() + _i * pt->getZ() + _zoff;
//     pt->setX(x);
//     pt->setY(y);
//     pt->setZ(z);
//     return pt;
// }

// OGRPoint ScAffine::transform(const OGRPoint& pt)
// {
//     qDebug() << "a: " << _a << ", b: " << _b << ", d: " << _d << ", e: " << _e << ", xoff: " << _xoff << ", yoff: " << _yoff;
//     double x = _a * pt.getX() + _b * pt.getY() + _c * pt.getZ() + _xoff;
//     double y = _d * pt.getX() + _e * pt.getY() + _f * pt.getZ() + _yoff;
//     double z = _g * pt.getY() + _h * pt.getY() + _i * pt.getZ() + _zoff;
//     return OGRPoint(x,y,z);
// }

// void ScAffine::translate(double xoff, double yoff, double zoff)
// {
//     _xoff = xoff;
//     _yoff = yoff;
//     _zoff = zoff;
// }

// void ScAffine::scale(double scaleX, double scaleY, double scaleZ)
// {
//     _a *= scaleX;
//     _b *= scaleY;
//     _c *= scaleZ;
//     _xoff *= scaleX;
//     _d *= scaleX;
//     _e *= scaleY;
//     _f *= scaleZ;
//     _yoff *= scaleY;
//     _g *= scaleX;
//     _h *= scaleY;
//     _i *= scaleZ;
//     _zoff *= scaleZ;
// }

// void ScAffine::rotate(double angle)
// {
//     double a,b,d,e;
//     a = cos(angle)  ;
//     b = -sin(angle)  ;
//     d = sin(angle)  ;
//     e = cos(angle) ;
//     _a = a;
//     _b = b;
//     _d = d;
//     _e = e;
// }

// #define EQ(v1,v2)   fabs((v1)-(v2)) < 0.000000001

// void ScAffine::rotateDegree(double degree)
// {
//     double a,b,d,e;
//     double rad = degree / 180.0 * M_PI;
//     double sina,cosa;
//     if (EQ(degree,90.0) || EQ(degree,-270.0)){
//         sina = 1.;
//         cosa = 0.0;
//     }else if (EQ(degree,270) || EQ(degree , -90.)){
//         sina = -1.;
//         cosa = 0.0;
//     }else if (EQ(degree,180.)){
//         cosa = -1.;
//         sina = 0.0;
//     }else{
//         sina = sin(rad);
//         cosa = cos(rad);
//     }

//     a = _a*cosa + _b * sina;
//     b = _e*cosa + _d * sina;
//     d = -_a*sina + _b * cosa;
//     e = -_e*sina + _d * cosa;

//     _a  = a;
//     _b = b;
//     _d = d;
//     _e = e;
// }


void ScAffine::setParameters(OGREnvelope& fromEv, OGREnvelope& toEv){

}

OGRPoint* ScAffine::transform(OGRPoint* pt){
    if(_parameters.empty()){
        return pt;
    }

}

OGRPoint ScAffine::transform(const OGRPoint& pt){

}

void ScAffine::translate(double xoff, double yoff, double zoff){
    AffineParameters param ={
        1,0,0,0,1,0,0,0,1,xoff,yoff,zoff
    };
    _parameters.push_back(param);
}

void ScAffine::scale (double scaleX, double scaleY, double scaleZ ){
    AffineParameters param ={
        scaleX,0,0,0,scaleY,0,0,0,scaleZ,0,0,0
    };
    _parameters.push_back(param);
}

void ScAffine::rotate(double angle){

}

void ScAffine::rotateDegree(double degree){

}

void ScAffine::reset()
{
    _parameters.clear();
    // AffineParameters param ={
    //     1,0,0,0,1,0,0,0,1,0,0,0
    // };
    // _parameters.push_back(param);
}
