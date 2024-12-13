#ifndef __SCIMAGE_H
#define __SCIMAGE_H

#include <QQuickPaintedItem>
#include <QtCore>


class ScImage : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(ScImage)


    Q_PROPERTY(QString src READ src WRITE setSrc NOTIFY srcChanged FINAL)
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged FINAL)
    Q_PROPERTY(int fillMode READ fillMode WRITE setFillMode NOTIFY fillModeChanged FINAL)
public:
    explicit ScImage(QQuickItem* parent = nullptr);
    void paint(QPainter* painter) override;
    virtual ~ScImage() override;

    QString src();
    void setSrc(const QString& src);

    qreal radius();
    void setRadius(qreal radius);


    int fillMode() const;
    void setFillMode(int fillmode);

protected:
    QString _src;
    qreal _radius;
    int _fillMode;
signals:
    void srcChanged();
    void radiusChanged();
    void fillModeChanged();
};

#endif // PCIMAGE_H
