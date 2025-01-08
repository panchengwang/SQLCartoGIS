#ifndef __SC_MAP_CONTROL_H
#define __SC_MAP_CONTROL_H

#include <QtQuick/QQuickPaintedItem>
#include <ogr_api.h>
#include <ogr_geometry.h>

class ScMapControl : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(ScMapControl)

    Q_PROPERTY(int srid READ srid WRITE setSrid NOTIFY sridChanged FINAL)

public:
    explicit ScMapControl(QQuickItem* parent = nullptr);
    void paint(QPainter* painter) override;
    ~ScMapControl() override;


    int srid() const;
    void setSrid(int srid);

    void setInitialMapExtent(const OGREnvelope& ev);
    Q_INVOKABLE void setInitialMapExtent(double minx, double miny, double maxx, double maxy);
protected:
    void mouseMoveEvent(QMouseEvent* event);
    void mousePressEvent(QMouseEvent* event);
    void mouseReleaseEvent(QMouseEvent* event);
    void geometryChange(const QRectF &newGeometry, const QRectF &oldGeometry);

signals:
    void sridChanged();

protected:
    int  _srid;

    QTransform _transform;
    // OGRPoint    _center;
    // double  _scale;

};

#endif 
