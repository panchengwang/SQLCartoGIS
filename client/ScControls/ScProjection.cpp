#include "ScProjection.h"


ScProjection::ScProjection(QObject *parent)
    : QObject{parent}
{

}

bool ScProjection::transform(OGRPoint* pt, int srcSrid, int targetSrid)
{
    return true;
}
