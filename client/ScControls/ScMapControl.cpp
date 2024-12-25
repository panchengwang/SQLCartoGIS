#include "ScMapControl.h"

#include <QPainter>

ScMapControl::ScMapControl(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
}

void ScMapControl::paint(QPainter* painter)
{

}

ScMapControl::~ScMapControl()
{
}

int ScMapControl::srid() const
{
    return _srid;
}

void ScMapControl::setSrid(int srid)
{
    _srid = srid;
}
