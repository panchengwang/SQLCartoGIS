#include "PcMapControl.h"

#include <QPainter>

PcMapControl::PcMapControl(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
}

void PcMapControl::paint(QPainter* painter)
{

}

PcMapControl::~PcMapControl()
{
}
