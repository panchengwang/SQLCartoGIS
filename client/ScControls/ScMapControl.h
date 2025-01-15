#ifndef __SC_MAP_CONTROL_H
#define __SC_MAP_CONTROL_H

#include <QtQuick/QQuickPaintedItem>
#include <ogr_api.h>
#include <ogr_geometry.h>
#include <ScAffine.h>


class ScMapControl : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(ScMapControl)

    Q_PROPERTY(int srid READ srid WRITE setSrid NOTIFY sridChanged FINAL)

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

protected:
    void mouseMoveEvent(QMouseEvent* event) override;
    void mousePressEvent(QMouseEvent* event) override;
    void mouseReleaseEvent(QMouseEvent* event) override;
    void hoverMoveEvent(QHoverEvent *event);
    void geometryChange(const QRectF &newGeometry, const QRectF &oldGeometry) override;
    void wheelEvent(QWheelEvent *) override;

protected slots:
    void onSizeChanged();

signals:
    void sridChanged();
    void mapClicked(const QJsonObject& pixel, const QJsonObject& coord);
protected:
    int  _srid;
    OGREnvelope _envelope;
    OGRPoint _center;
    double _scale;
    bool _isMapExtentOK;


    int _currentDrawType;
    bool _isDrawing;
    std::vector<OGRPoint> _draft;
    std::vector<OGRGeometry*> _draftGeometries;
    QImage *_draftImage;
private:
    void recalculateMapExtent();
    void clearDrafts();
};

#endif 
