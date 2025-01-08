#include "ScMapControl.h"

#include <QPainter>
#include "ScAffine.h"

ScMapControl::ScMapControl(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);

    setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::AllButtons);


    OGREnvelope ev;
    ev.MinX = -180;
    ev.MaxX = 180;
    ev.MinY = -90;
    ev.MaxY = 90;
    setInitialMapExtent(ev);
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

void ScMapControl::setInitialMapExtent(const OGREnvelope& ev)
{
    double sx = width() / fabs(ev.MaxX - ev.MinX);
    double sy = height() / fabs(ev.MaxY - ev.MinY);
    double scale = sx < sy ? sx : sy;

}

void ScMapControl::setInitialMapExtent(double minx, double miny, double maxx, double maxy)
{
    OGREnvelope ev;
    ev.MinX = minx;
    ev.MaxX = maxx;
    ev.MinY = miny;
    ev.MaxY = maxy;
    setInitialMapExtent(ev);
}

void ScMapControl::mouseMoveEvent(QMouseEvent* event)
{
    qDebug() <<  event->pos();

    qDebug() << "after transform map" <<  _transform.map(event->pos());
}

void ScMapControl::mousePressEvent(QMouseEvent* event)
{
    if(event->button() == Qt::RightButton){

    }else if(event->button() == Qt::LeftButton){
        qDebug() <<  event->pos();

        qDebug() << "after transform map" <<  _transform.map(QPoint(0,100));
    }
}

void ScMapControl::mouseReleaseEvent(QMouseEvent* event)
{
    if(event->button() == Qt::RightButton){

    }else if(event->button() == Qt::LeftButton){

    }
}

void ScMapControl::geometryChange(const QRectF& newGeometry, const QRectF& oldGeometry)
{
    ScAffine affine;
    OGRPoint pt(-90,-45);

    OGREnvelope ev1,ev2;
    ev1.MinX = -180;
    ev1.MaxX = 180;
    ev1.MinY = -180;
    ev1.MaxY = 180;
    // ev2.MinX = ev2.MinY = -200;
    // ev2.MaxX =  ev2.MaxY = 200;
    ev2.MinX = ev2.MinY = 0;
    ev2.MaxX = 400; ev2.MaxY = 400;
    affine.setParameters(ev1,ev2);

    // affine.reset();
    // affine.translate(0,0);
    // affine.scale(0.5,0.5,0.5);
    // // affine.rotateDegree(45);

    OGRPoint pt2 = affine.transform(pt);

}
