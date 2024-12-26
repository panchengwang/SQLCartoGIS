#ifndef SCWEBMAPCONTROL_H
#define SCWEBMAPCONTROL_H

#include <QQuickPaintedItem>
#include <geos.h>
// #include <ogrsf_frmts.h>

class ScWebMapControl : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int z READ z WRITE setZ FINAL)
public:
    ScWebMapControl(QQuickItem *parent = nullptr);
    virtual ~ScWebMapControl();

    virtual void paint(QPainter *painter);

    int z() const;
    void setZ(int z);

    Q_INVOKABLE double getResolutionOfZ(int z);

public slots:


protected:
    // OGREnvelope _envelope;
    // OGRPoint _center;
    geos::geom::Point* _center;

    int _z;
    double _resolutions[24] = {
        156543.03392804097,
        78271.51696402048,
        39135.75848201024,
        19567.879241005125,
        9783.93962050257,
        4891.9698102512775,
        2445.984905125646,
        1222.9924525628157,
        611.4962262814079,
        305.7481131407112,
        152.87405657034833,
        76.43702828517416,
        38.21851414258708,
        19.109257071308093,
        9.554628535654047,
        4.777314267834299,
        2.3886571339098737,
        1.1943285669549368,
        0.5971642834774684,
        0.2985821417387342,
        0.14929107087664306,
        0.07464553543832153,
        0.037322767719160765,
        0.018661383859580383
    };
};

#endif // SCWEBMAPCONTROL_H
