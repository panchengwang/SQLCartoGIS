#include "ScAffine.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>

ScAffine::ScAffine(QObject *parent)
    : QObject{parent}
{
    reset();
}

ScAffine::ScAffine(const ScAffine& other)
{
    _matrix = other._matrix;
}

void ScAffine::setParameters(double a, double b, double d, double e, double xoff, double yoff)
{
    cairo_matrix_init (&_matrix,a,d,b,e,xoff,yoff);
}


void ScAffine::setParameters(OGREnvelope& fromEv, OGREnvelope& toEv){
    double sx = (toEv.MaxX - toEv.MinX) / (fromEv.MaxX - fromEv.MinX);
    double sy = (toEv.MaxY - toEv.MinY) / (fromEv.MaxY - fromEv.MinY);
    double scale = fabs(sx) < fabs(sy) ? fabs(sx) : fabs(sy);
    int xsign = sx > 0 ? 1 : -1;
    int ysign = sy > 0 ? 1 : -1;
    double xoff = (toEv.MinX + toEv.MaxX)*0.5 - (fromEv.MinX + fromEv.MaxX)*0.5*scale * xsign;
    double yoff = (toEv.MinY + toEv.MaxY)*0.5 - (fromEv.MinY + fromEv.MaxY)*0.5*scale * ysign;
    // reset();
    // this->scale(xsign*scale,ysign* scale);
    // this->translate(xoff,yoff);
    setParameters(xsign*scale, 0, 0, ysign*scale, xoff,yoff);
}


OGRPoint* ScAffine::transform(OGRPoint* pt){
    double x = pt->getX();
    double y = pt->getY();
    double x1 = _matrix.xx * x + _matrix.xy * y + _matrix.x0;
    double y1 = _matrix.yx * x + _matrix.yy * y + _matrix.y0;
    pt->setX(x);
    pt->setY(y);
    return pt;
}

OGRPoint ScAffine::transform(const OGRPoint& pt){
    double x = pt.getX();
    double y = pt.getY();
    double x1 = _matrix.xx * x + _matrix.xy * y + _matrix.x0;
    double y1 = _matrix.yx * x + _matrix.yy * y + _matrix.y0;
    return OGRPoint(x1,y1);
}

void ScAffine::translate(double xoff, double yoff){
    cairo_matrix_t transMatrix;
    cairo_matrix_init_identity(&transMatrix);
    cairo_matrix_init_translate(&transMatrix,xoff,yoff);
    cairo_matrix_multiply(&_matrix,&_matrix,&transMatrix);
}

void ScAffine::scale (double scaleX, double scaleY ){
    cairo_matrix_t scaleMatrix;
    cairo_matrix_init_identity(&scaleMatrix);
    cairo_matrix_init_scale(&scaleMatrix,scaleX,scaleY);
    cairo_matrix_multiply(&_matrix,&_matrix,&scaleMatrix);
}

void ScAffine::rotate(double angle){
    cairo_matrix_t rotateMatrix;
    cairo_matrix_init_identity(&rotateMatrix);
    cairo_matrix_init_rotate(&rotateMatrix,angle);
    cairo_matrix_multiply(&_matrix,&_matrix,&rotateMatrix);
}

void ScAffine::rotateDegree(double degree){
    rotate(degree/180.0 * M_PI);
}

void ScAffine::reset()
{
    cairo_matrix_init_identity(&_matrix);
}

ScAffine ScAffine::inverted()
{
    ScAffine invAffine;
    invAffine._matrix = _matrix;
    cairo_status_t result = cairo_matrix_invert (& (invAffine._matrix));
    if(result != CAIRO_STATUS_SUCCESS){
        cairo_matrix_init_identity(& (invAffine._matrix));
    }
    return invAffine;
}

ScAffine& ScAffine::operator=(const ScAffine& other)
{
    _matrix = other._matrix;
    return *this;
}


