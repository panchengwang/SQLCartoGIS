#include "PcImage.h"
#include <QPainter>
#include <QPainterPath>

PcImage::PcImage(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
}

void PcImage::paint(QPainter* painter)
{
    if(_src.isEmpty() || _src.trimmed() == ""){
        return;
    }

    QPainterPath path;
    QRectF clipRect(0,0,width(),height());

    path.addRoundedRect(clipRect, _radius,_radius);
    painter->setClipPath(path,Qt::IntersectClip);
    QImage img(_src);
    QRectF imageRect = img.rect();
    QRectF targetRect = clipRect;

    if(_fillMode == 1 || _fillMode == 2){
        double sx = width() / imageRect.width() ;
        double sy = height() / imageRect.height() ;
        double s = 1;
        if(_fillMode == 1){             // Image.PreserveAspectFit
            s = sx < sy ? sx : sy;
        }else if(_fillMode == 2){       // Image.PreserveAspectCrop
            s = sx > sy ? sx : sy;
        }
        double w = imageRect.width() * s;
        double h = imageRect.height() * s;

        double x = (width() - w) * 0.5;
        double y = (height() - h) * 0.5;
        targetRect = QRectF(x,y,w,h);
    }

    painter->drawImage(targetRect,img,imageRect);
}

PcImage::~PcImage()
{

}

QString PcImage::src()
{
    return _src;
}

void PcImage::setSrc(const QString& src)
{
    _src = src;

    update();
}

qreal PcImage::radius()
{
    return _radius;
}

void PcImage::setRadius(qreal radius)
{
    _radius = radius;
    update();
}

int PcImage::fillMode() const
{
    return _fillMode;
}

void PcImage::setFillMode(int fillmode)
{
    _fillMode = fillmode;
    update();
}
