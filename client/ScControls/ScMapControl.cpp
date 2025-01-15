#include "ScMapControl.h"

#include <QPainter>
#include "ScAffine.h"
#include "ScOGRPoint.h"
#include <QJsonObject>
#include <QtCore>
#include <QQuickWindow>
#include <QScreen>

ScMapControl::ScMapControl(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);

    setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::AllButtons);



    _envelope.MinX = -50;
    _envelope.MaxX = 100;
    _envelope.MinY = -50;
    _envelope.MaxY = 100;
    _isMapExtentOK = false;

    // _envelope.MinX = 111;
    // _envelope.MaxX = 112;
    // _envelope.MinY = 28;
    // _envelope.MaxY = 29;

    _currentDrawType = DrawType::LINESTRING;
    _isDrawing = false;
    _draftImage = NULL;
}

void ScMapControl::paint(QPainter* painter)
{

    if(_draftImage){
        drawDraftGeometries();
        painter->drawImage(boundingRect(),*_draftImage, _draftImage->rect());
    }
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

// OGREnvelope ScMapControl::getMapExtent()
// {
//     // OGRPoint pt1(0,height());
//     // OGRPoint pt2(width(),0);
//     // _affineInvert.transform(&pt1);
//     // _affineInvert.transform(&pt2);
//     // OGREnvelope ev;

//     // ev.MinX = pt1.getX();
//     // ev.MinY = pt1.getY();
//     // ev.MaxX = pt2.getX();
//     // ev.MaxY = pt2.getY();
//     // return ev;
// }

void ScMapControl::drawDraftGeometries()
{
    if(!_draftImage){
        return;
    }
    _draftImage->fill(QColor(255,255,255,0));
    QPainter painter(_draftImage);
    painter.setRenderHint(QPainter::Antialiasing);



    QTransform oldtrans=painter.transform();
    QTransform trans;
    QScreen *screen = this->window()->screen();
    trans.scale(screen->devicePixelRatio(),screen->devicePixelRatio());
    painter.setTransform(trans);


    for(size_t i=0; i<_draftGeometries.size(); i++){
        OGRGeometry* geo = _draftGeometries[i];
        if(geo->getGeometryType() == OGRwkbGeometryType::wkbPoint){
            QPointF pt = mapToPixel(*(OGRPoint*)geo);
            painter.drawArc(pt.x()-5,pt.y()-5,10,10,0,360*16);
        }
    }


    if(_currentDrawType == DrawType::LINESTRING){
        for(size_t i=0; i<_draft.size(); i++){
            QPointF pt = mapToPixel(_draft[i]);
            painter.drawArc(pt.x()-5,pt.y()-5,10,10,0,360*16);
        }
    }

    painter.setTransform(oldtrans);
}

OGRPoint ScMapControl::pixelToMap(const QPointF& pixel)
{
    double x,y;
    x = (pixel.x() - width()*0.5)/_scale + _center.getX();
    y = _center.getY() - (pixel.y() - height()*0.5)/_scale;
    return OGRPoint(x,y);
}

QPointF ScMapControl::mapToPixel(const OGRPoint& coord)
{
    double x,y;
    x = width()*0.5 + (coord.getX() - _center.getX()) * _scale;
    y = height()*0.5 - (coord.getY() - _center.getY()) * _scale;
    return QPointF(x,y);
}



void ScMapControl::mouseMoveEvent(QMouseEvent* event)
{
    // if(_currentDrawType == DrawType::LINESTRING){
    //     qDebug() << event->pos();
    // }

    // event->accept();
}

void ScMapControl::mousePressEvent(QMouseEvent* event)
{
    if(event->button() == Qt::RightButton){

    }else if(event->button() == Qt::LeftButton){

    }

    event->accept();
}

void ScMapControl::mouseReleaseEvent(QMouseEvent* event)
{
    if(event->button() == Qt::RightButton){

    }else if(event->button() == Qt::LeftButton){

        OGRPoint coord = pixelToMap(event->pos());

        if(_currentDrawType == DrawType::NOTHING)
        {
            QVariantMap pixelmap;
            pixelmap["x"] = event->pos().x();
            pixelmap["y"] = event->pos().y();
            QVariantMap coordmap;
            coordmap["x"] = coord.getX();
            coordmap["y"] = coord.getY();
            emit mapClicked(QJsonObject::fromVariantMap(pixelmap), QJsonObject::fromVariantMap(coordmap));
        }else if(_currentDrawType == DrawType::POINT){
            _isDrawing = false;
            _draftGeometries.push_back(new OGRPoint(coord));

            // drawDraftGeometries();
            update();
        }else if(_currentDrawType == DrawType::LINESTRING){
            _draft.push_back(coord);
            update();
            // _isDrawing = true;
        }
    }

    event->accept();
}

void ScMapControl::hoverMoveEvent(QHoverEvent* event)
{
    if(_currentDrawType == DrawType::LINESTRING){
        qDebug() << event->pos();
    }

    event->accept();
}

void ScMapControl::geometryChange(const QRectF& newGeometry, const QRectF& oldGeometry)
{
    if(newGeometry.width()==0 || newGeometry.height() == 0){
        return;
    }

    if(!_isMapExtentOK){
        double sx = newGeometry.width() / (_envelope.MaxX - _envelope.MinX);
        double sy = newGeometry.height() / (_envelope.MaxY - _envelope.MinY);
        _scale = sx < sy ? sx : sy;
        _center.setX((_envelope.MinX + _envelope.MaxX)*0.5);
        _center.setY((_envelope.MinY + _envelope.MaxY)*0.5);
        _isMapExtentOK = true;
    }

    if(_isMapExtentOK){
        recalculateMapExtent();
    }

    if(_draftImage){
        delete _draftImage;
    }

    QScreen *screen = this->window()->screen();
    _draftImage = new QImage(screen->devicePixelRatio()*newGeometry.width(),screen->devicePixelRatio()*newGeometry.height(),QImage::Format_ARGB32);

    update();
}

void ScMapControl::wheelEvent(QWheelEvent* event)
{
    QPointF pos = event->position();
    OGRPoint beforeCoord = pixelToMap(pos);
    double s = 1.0;
    if(event->angleDelta().y() > 0){
        s = 2.0;
    }else if(event->angleDelta().y() < 0){
        s = 1.0/2.0;
    }
    _scale *= s;
    OGRPoint afterCoord = pixelToMap(pos);
    double xoff = afterCoord.getX() - beforeCoord.getX();
    double yoff = afterCoord.getY() - beforeCoord.getY();
    _center.setX(_center.getX() - xoff);
    _center.setY(_center.getY() - yoff);
    update();
    event->accept();
}



void ScMapControl::onSizeChanged()
{

}

void ScMapControl::recalculateMapExtent()
{
    _envelope.MinX = _center.getX() - (width()*0.5)/_scale ;
    _envelope.MaxX = _center.getX() + (width()*0.5)/_scale ;
    _envelope.MinY = _center.getY() - (height()*0.5)/_scale;
    _envelope.MaxY = _center.getY() + (height()*0.5)/_scale;
}

void ScMapControl::clearDrafts()
{
    for(size_t i=0; i<_draftGeometries.size(); i++){
        delete _draftGeometries.at(i);
    }
    _draftGeometries.clear();

    _draft.clear();
}
