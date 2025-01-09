#include "ScAffineParameter.h"
#include <stdlib.h>


ScAffineParameter::ScAffineParameter(){
    _type = OperatorType::NORMAL;
    _a = 1.0;
    _b = 0.0;
    _d = 0.0;
    _e = 1.0;
    _xoff = 0;
    _yoff = 0;
}

ScAffineParameter::ScAffineParameter(const ScAffineParameter& param)
{
    _type = param._type;
    _a = param._a;
    _b = param._b;
    _d = param._d;
    _e = param._e;
    _xoff = param._xoff;
    _yoff = param._yoff;
}


ScAffineParameter::ScAffineParameter(double a, double b, double d, double e, double xoff, double yoff){
    _type = OperatorType::NORMAL;
    _a = a;
    _b = b;
    _d = d;
    _e = e;
    _xoff = xoff;
    _yoff = yoff;
}



std::string ScAffineParameter::toString()
{
    char buf[1024];
    std::string typestr;
    switch(_type){
    case OperatorType::TRANSLATE:
        typestr = "translate: ";
        break;
    case OperatorType::SCALE:
        typestr = "scale: ";
        break;
    case OperatorType::ROTATE:
        typestr = "roate: ";
        break;
    default:
        typestr = "unknown: ";
        break;
    }

    sprintf(buf,"  a: %lf, b: %lf, d: %lf, e: %lf, xoff: %lf, yoff: %lf", _a ,_b,_d,_e,_xoff,_yoff);
    return typestr + buf;
}
