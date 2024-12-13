#ifndef __SC_MAP_CONTROL_H
#define __SC_MAP_CONTROL_H

#include <QtQuick/QQuickPaintedItem>

class ScMapControl : public QQuickPaintedItem
{
    Q_OBJECT
        QML_ELEMENT
        Q_DISABLE_COPY(ScMapControl)
public:
    explicit ScMapControl(QQuickItem* parent = nullptr);
    void paint(QPainter* painter) override;
    ~ScMapControl() override;
};

#endif 
