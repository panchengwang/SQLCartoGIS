#ifndef SCWEBMAPCONTROL_H
#define SCWEBMAPCONTROL_H

#include <QQuickPaintedItem>
#include <ogrsf_frmts.h>

class ScWebMapControl : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT

public:
    ScWebMapControl(QQuickItem *parent = nullptr);
    virtual ~ScWebMapControl();

    virtual void paint(QPainter *painter);

signals:
    OGREnvelope _envelope;
    OGRPoint _center;
    int _z;
};

#endif // SCWEBMAPCONTROL_H
