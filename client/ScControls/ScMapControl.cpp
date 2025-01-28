#include "ScMapControl.h"

#include <QPainter>
#include "ScAffine.h"
#include "ScOGRPoint.h"
#include <QJsonObject>
#include <QtCore>
#include <QQuickWindow>
#include <QScreen>
#include "ScGeometryIO.h"


ScMapControl::ScMapControl(QQuickItem* parent)
    : QQuickPaintedItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);

    setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::AllButtons);

    _srid = 4326;
    // _envelope.MinX = -180;
    // _envelope.MaxX = 180;
    // _envelope.MinY = -90;
    // _envelope.MaxY = 90;
    _envelope.MinX = 110;
    _envelope.MaxX = 112;
    _envelope.MinY = 28;
    _envelope.MaxY = 30;
    _isMapExtentOK = false;



    _isDraging = false;
    _dragBegin = _dragEnd = QPointF(0,0);
    _currentDrawType = DrawType::NOTHING;
    _isDrawing = false;
    _draftImage = NULL;




    _resolutions.push_back(  156543.03392804097);
    _resolutions.push_back(   78271.51696402048);
    _resolutions.push_back(   39135.75848201024);
    _resolutions.push_back(  19567.879241005125);
    _resolutions.push_back(    9783.93962050257);
    _resolutions.push_back(  4891.9698102512775);
    _resolutions.push_back(   2445.984905125646);
    _resolutions.push_back(  1222.9924525628157);
    _resolutions.push_back(   611.4962262814079);
    _resolutions.push_back(   305.7481131407112);
    _resolutions.push_back(  152.87405657034833);
    _resolutions.push_back(   76.43702828517416);
    _resolutions.push_back(   38.21851414258708);
    _resolutions.push_back(  19.109257071308093);
    _resolutions.push_back(   9.554628535654047);
    _resolutions.push_back(   4.777314267834299);
    _resolutions.push_back(  2.3886571339098737);
    _resolutions.push_back(  1.1943285669549368);
    _resolutions.push_back(  0.5971642834774684);
    _resolutions.push_back(  0.2985821417387342);
    _resolutions.push_back( 0.14929107087664306);
    _resolutions.push_back( 0.07464553543832153);
    _resolutions.push_back(0.037322767719160765);
    _resolutions.push_back(0.018661383859580383);
    _enableWebMap = false;
}

void ScMapControl::paint(QPainter* painter)
{


    double xoff = 0;
    double yoff = 0;
    if(_isDraging){
        xoff = _dragBegin.x()-_dragEnd.x();
        yoff = _dragBegin.y()-_dragEnd.y();
        xoff *= this->window()->screen()->devicePixelRatio();
        yoff *= this->window()->screen()->devicePixelRatio();
    }

    if(_draftImage){
        drawDraftGeometries();
        QRectF rect = _draftImage->rect();
        rect.translate(xoff,yoff);
        painter->drawImage(boundingRect(),*_draftImage, rect);
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
        drawGeometry(&painter,geo);
        // if(geo->getGeometryType() == OGRwkbGeometryType::wkbPoint){
        //     QPointF pt = mapToPixel(*(OGRPoint*)geo);
        //     painter.drawArc(pt.x()-5,pt.y()-5,10,10,0,360*16);
        // }else if(geo->getGeometryType() == OGRwkbGeometryType::wkbLineString){

        // }
    }


    if(_currentDrawType == DrawType::LINESTRING){
        size_t ptcount=_draft.size();
        if(_isDrawing){
            ptcount ++;
        }
        QPointF *pts = new QPointF[ptcount];
        for(size_t i=0; i<_draft.size(); i++){
            pts[i] = mapToPixel(_draft[i]);
        }
        if(_isDrawing){
            pts[ptcount-1] = mapToPixel(_hoverPoint);
        }
        // if(_draft.size() >= 2){
            painter.drawPolyline(pts,ptcount);
        // }

        for(size_t i=0; i<ptcount; i++){
            painter.drawArc(pts[i].x()-5,pts[i].y()-5,10,10,0,360*16);
        }
        delete [] pts;
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

void ScMapControl::drawGeometry(QPainter* painter, OGRGeometry* geo)
{
    if(geo->getGeometryType() == OGRwkbGeometryType::wkbPoint ){
        drawGeometry(painter, (OGRPoint*)geo);
    }else if(geo->getGeometryType() == OGRwkbGeometryType::wkbLineString ){
        drawGeometry(painter, (OGRLineString*)geo);
    }else if(geo->getGeometryType() == OGRwkbGeometryType::wkbPolygon ){
        drawGeometry(painter, (OGRPolygon*)geo);
    }else if(geo->getGeometryType() == OGRwkbGeometryType::wkbGeometryCollection){
        OGRGeometryCollection *col = (OGRGeometryCollection*)geo;
        for(size_t i=0; i<col->getNumGeometries(); i++){
            drawGeometry(painter, col->getGeometryRef(i));
        }
    }
}

void ScMapControl::drawGeometry(QPainter* painter, OGRPoint* pt)
{
    QPointF pixel = mapToPixel(*pt);
    painter->drawArc(pixel.x() -5, pixel.y()-5,10,10,0,360*16);
}

void ScMapControl::drawGeometry(QPainter* painter, OGRLineString* ls)
{
    if(ls->getNumPoints()<2){
        return;
    }

    QPointF *pts = new QPointF[ls->getNumPoints()];
    for(int i=0; i<ls->getNumPoints(); i++){
        OGRPoint pt;
        ls->getPoint(i,&pt);
        pts[i] = mapToPixel(pt);
    }
    painter->drawPolyline(pts,ls->getNumPoints());
}

void ScMapControl::drawGeometry(QPainter* painter, OGRPolygon* pg)
{

}

bool ScMapControl::enableWebMap() const
{
    return _enableWebMap;
}

void ScMapControl::setEnableWebMap(bool enableWebMap)
{
    _enableWebMap = enableWebMap;
}

int ScMapControl::getNearestZoomLevel()
{

    OGRPoint pt = pixelToMap(QPointF(width()*0.5+1,height()*0.5));      // 中心点右偏1个像素点的地理位置
    if(!_sdb.isValid()){
        qDebug() << _sdb.errorMessage();
        return 3;
    }

    ScGeometryIO io;
    OGRPoint* center3857 =(OGRPoint*)_sdb.reproject(&_center,_srid,3857);
    OGRPoint* pt3857 =(OGRPoint*)_sdb.reproject(&pt,_srid,3857);
    qDebug() << "resolution: " << pt3857->getX() - center3857->getX();
    return 0;
}



void ScMapControl::mouseMoveEvent(QMouseEvent* event)
{
    // if(_currentDrawType == DrawType::LINESTRING){
    //     qDebug() << event->pos();
    // }

    // event->accept();

        // qDebug() << event->buttons();
    OGRPoint coord = pixelToMap(event->pos());
    if( event->buttons() & Qt::LeftButton){
        _isDraging = true;
        _dragEnd = event->position();
        update();
    }
    event->accept();
}

void ScMapControl::mousePressEvent(QMouseEvent* event)
{
    OGRPoint coord = pixelToMap(event->pos());
    if(event->button() == Qt::RightButton){

    }else if(event->button() == Qt::LeftButton){
        _dragBegin = event->position();
        _dragEnd = _dragBegin;
    }

    event->accept();
}

void ScMapControl::mouseReleaseEvent(QMouseEvent* event)
{
    OGRPoint coord = pixelToMap(event->pos());

    if(event->button() == Qt::RightButton){
        if(_currentDrawType == DrawType::LINESTRING){
            _isDrawing = false;

            if(_draft.size() > 2){
                OGRLineString *ls = new OGRLineString();
                for(size_t i=0; i<_draft.size();i++){
                    ls->addPoint(_draft[i].getX(),_draft[i].getY());
                }
                _draftGeometries.push_back(ls);
            }
            _draft.clear();
            update();
        }
    }else if(event->button() == Qt::LeftButton){
        if(_isDraging){
            _isDraging = false;
            OGRPoint begin = pixelToMap(_dragBegin);
            OGRPoint end = pixelToMap(_dragEnd);
            double xoff = end.getX() - begin.getX();
            double yoff = end.getY() - begin.getY();
            _center.setX(_center.getX() - xoff);
            _center.setY(_center.getY() - yoff);
            _dragEnd = _dragBegin;
            update();
            return;
        }

        if(_currentDrawType == DrawType::NOTHING){
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
            update();
        }else if(_currentDrawType == DrawType::LINESTRING){
            _draft.push_back(coord);
            update();
            _isDrawing = true;
        }
    }

    event->accept();
}

void ScMapControl::hoverMoveEvent(QHoverEvent* event)
{
    _hoverPoint = pixelToMap(event->position());

    if(_currentDrawType == DrawType::LINESTRING){
        if(_isDrawing){
            update();
        }
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

    getNearestZoomLevel();
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
