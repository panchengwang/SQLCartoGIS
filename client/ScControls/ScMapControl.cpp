#include "ScMapControl.h"

#include <QPainter>
#include "ScAffine.h"
#include "ScOGRPoint.h"
#include <QJsonObject>
#include <QtCore>


ScMapControl::ScMapControl(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);

    setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::AllButtons);



    _envelope.MinX = 110;
    _envelope.MaxX = 111;
    _envelope.MinY = 28;
    _envelope.MaxY = 29;

}

void ScMapControl::paint(QPainter* painter)
{
    painter->drawArc(
        QRect(QPoint(width()*0.5-5,height()*0.5-5),QSize(10,10)),
        0,
        360*16
    );

    OGRPoint pt1(_envelope.MinX,_envelope.MinY);
    OGRPoint pt2(_envelope.MinX,_envelope.MaxY);
    OGRPoint pt3(_envelope.MaxX,_envelope.MaxY);
    OGRPoint pt4(_envelope.MaxX,_envelope.MinY);
    pt1 = _affine.transform(pt1);
    pt2 = _affine.transform(pt2);
    pt3 = _affine.transform(pt3);
    pt4 = _affine.transform(pt4);

    QRect rect(
        QPoint(pt1.getX(),pt1.getY()),
        QPoint(pt3.getX(),pt3.getY())
    );

    painter->drawRect(rect);
}

void ScMapControl::drawGrid(QPainter* painter, double xstep, double ystep)
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

// void ScMapControl::setInitialMapExtent(const OGREnvelope& ev)
// {
//     double sx = width() / fabs(ev.MaxX - ev.MinX);
//     double sy = height() / fabs(ev.MaxY - ev.MinY);
//     double scale = sx < sy ? sx : sy;

// }

// void ScMapControl::setInitialMapExtent(double minx, double miny, double maxx, double maxy)
// {
//     OGREnvelope ev;
//     ev.MinX = minx;
//     ev.MaxX = maxx;
//     ev.MinY = miny;
//     ev.MaxY = maxy;
//     setInitialMapExtent(ev);
// }

void ScMapControl::mouseMoveEvent(QMouseEvent* event)
{
    // qDebug() <<  event->pos();

    // OGRPoint pt(event->pos().x(),event->pos().y());
    // OGRPoint pt2 = _affine.inverted().transform(pt);
    // qDebug() << pt2.getX() << pt2.getY();
}

void ScMapControl::mousePressEvent(QMouseEvent* event)
{
    if(event->button() == Qt::RightButton){

    }else if(event->button() == Qt::LeftButton){

    }
}

void ScMapControl::mouseReleaseEvent(QMouseEvent* event)
{
    if(event->button() == Qt::RightButton){

    }else if(event->button() == Qt::LeftButton){
        OGRPoint pixel(event->pos().x(),event->pos().y());
        OGRPoint coord = _affine.inverted().transform(pixel);

        QVariantMap pixelmap;
        pixelmap["x"] = pixel.getX();
        pixelmap["y"] = pixel.getY();
        QVariantMap coordmap;
        coordmap["x"] = coord.getX();
        coordmap["y"] = coord.getY();
        emit mapClicked(QJsonObject::fromVariantMap(pixelmap), QJsonObject::fromVariantMap(coordmap));
    }
}

void ScMapControl::geometryChange(const QRectF& newGeometry, const QRectF& oldGeometry)
{
    OGREnvelope rect;
    rect.MinX = 0;
    rect.MinY = newGeometry.height();
    rect.MaxX = newGeometry.width();
    rect.MaxY = 0;
    _affine.reset();
    _affine.setParameters(_envelope,rect);

}

void ScMapControl::onSizeChanged()
{
    // OGREnvelope ev;
    // ev.MinX = -180;
    // ev.MaxX = 180;
    // ev.MinY = -90;
    // ev.MaxY = 90;
    // OGREnvelope rect;
    // rect.MinX = 0;
    // rect.MinY = height();
    // rect.MaxX = width();
    // rect.MaxY = 0;
    // _affine.reset();
    // _affine.setParameters(ev,rect);

    // OGRPoint pt(ev.MinX,ev.MinY);
    // OGRPoint pt2 = _affine.transform(pt);
    // qDebug() << pt2.getX() << pt2.getY();
}
