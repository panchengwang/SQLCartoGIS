#ifndef __SC_MAP_CONTROL_H
#define __SC_MAP_CONTROL_H

#include <QtQuick/QQuickPaintedItem>

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


signals:
    void sridChanged();
protected:
    int  _srid;
};

#endif 
