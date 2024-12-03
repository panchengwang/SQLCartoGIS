#ifndef PCIMAGE_H
#define PCIMAGE_H

#include <QQuickPaintedItem>
#include <QtCore>


class PcImage : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(PcImage)


    Q_PROPERTY(QString src READ src WRITE setSrc NOTIFY srcChanged FINAL)
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged FINAL)
    Q_PROPERTY(int fillMode READ fillMode WRITE setFillMode NOTIFY fillModeChanged FINAL)
public:
    explicit PcImage(QQuickItem* parent = nullptr);
    void paint(QPainter* painter) override;
    virtual ~PcImage() override;

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
