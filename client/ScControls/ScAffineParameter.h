#ifndef SCAFFINEPARAMTER_H
#define SCAFFINEPARAMTER_H

#include <stdint.h>

#include <string>


class ScAffine;

class ScAffineParameter
{
    friend class ScAffine;
public:

    enum OperatorType{
        NORMAL = 0,
        TRANSLATE,
        SCALE,
        ROTATE
    };

    ScAffineParameter();
    ScAffineParameter(const ScAffineParameter& param);
    ScAffineParameter(double a, double b, double d, double e, double xoff, double yoff);

    std::string toString();
protected:
    uint8_t _type;
    double _a, _b, _d, _e, _xoff, _yoff;
};

#endif // SCAFFINEPARAMTER_H
