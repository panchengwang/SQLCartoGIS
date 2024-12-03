#ifndef __PC_MAP_CONTROL_H
#define __PC_MAP_CONTROL_H

#include <QtQuick/QQuickPaintedItem>

class PcMapControl : public QQuickPaintedItem
{
    Q_OBJECT
        QML_ELEMENT
        Q_DISABLE_COPY(PcMapControl)
public:
    explicit PcMapControl(QQuickItem* parent = nullptr);
    void paint(QPainter* painter) override;
    ~PcMapControl() override;
};

#endif 
