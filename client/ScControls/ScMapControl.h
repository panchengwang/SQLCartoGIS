#ifndef __SC_MAP_CONTROL_H
#define __SC_MAP_CONTROL_H

#include <QtQuick/QQuickPaintedItem>
#include <ogr_api.h>
#include <ogr_geometry.h>
#include <ScAffine.h>
#include <ScSpatialDatabase.h>

class ScMapControl : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(ScMapControl)

    Q_PROPERTY(int srid READ srid WRITE setSrid NOTIFY sridChanged FINAL)
    Q_PROPERTY(bool enableWebMap READ enableWebMap WRITE setEnableWebMap NOTIFY enableWebMapChanged FINAL)

    enum DrawType{
        NOTHING =1,
        POINT,
        LINESTRING,
        POLYGON
    };
public:
    explicit ScMapControl(QQuickItem* parent = nullptr);
    ~ScMapControl() override;

    void paint(QPainter* painter) override;

    void drawGrid(QPainter* painter, double xstep, double ystep);
    int srid() const;
    void setSrid(int srid);
    // OGREnvelope getMapExtent();

    void drawDraftGeometries();

    OGRPoint pixelToMap(const QPointF& pixel);
    QPointF mapToPixel(const OGRPoint& coord);

    void drawGeometry(QPainter* painter, OGRGeometry* geo);
    void drawGeometry(QPainter* painter, OGRPoint* pt);
    void drawGeometry(QPainter* painter, OGRLineString* ls);
    void drawGeometry(QPainter* painter, OGRPolygon* pg);

    bool enableWebMap() const;
    void setEnableWebMap(bool enableWebMap);

    int getNearestZoomLevel();

protected:
    void mouseMoveEvent(QMouseEvent* event) override;
    void mousePressEvent(QMouseEvent* event) override;
    void mouseReleaseEvent(QMouseEvent* event) override;
    void hoverMoveEvent(QHoverEvent *event) override;
    void geometryChange(const QRectF &newGeometry, const QRectF &oldGeometry) override;
    void wheelEvent(QWheelEvent *) override;

protected slots:
    void onSizeChanged();

signals:
    void sridChanged();
    void enableWebMapChanged();
    void mapClicked(const QJsonObject& pixel, const QJsonObject& coord);
protected:
    int  _srid;
    OGREnvelope _envelope;
    OGRPoint _center;
    double _scale;
    bool _isMapExtentOK;

    bool _isDraging;
    QPointF _dragBegin;
    QPointF _dragEnd;

    int _currentDrawType;
    bool _isDrawing;
    std::vector<OGRPoint> _draft;
    OGRPoint _hoverPoint;
    std::vector<OGRGeometry*> _draftGeometries;
    QImage *_draftImage;



    // for web map service
    std::vector<double> _resolutions;
    bool _enableWebMap;
    int _minZoomLevel = 3;
    int _maxZoomLevel = 20;

    ScSpatialDatabase   _sdb;
private:
    void recalculateMapExtent();
    void clearDrafts();
};

#endif 
