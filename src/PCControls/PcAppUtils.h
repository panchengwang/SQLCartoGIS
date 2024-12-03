#ifndef PCAPPUTILS_H
#define PCAPPUTILS_H

#include <QQuickPaintedItem>
#include <QtCore>


class PcAppUtils : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(PcAppUtils)

public:
    explicit PcAppUtils(QQuickItem* parent = nullptr);
    virtual ~PcAppUtils() override;

    Q_INVOKABLE QString applicationFilePath();
    Q_INVOKABLE QString applicationDirPath();

};

#endif // PCIMAGE_H
