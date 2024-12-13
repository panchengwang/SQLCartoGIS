#ifndef __SCAPPUTILS_H
#define __SCAPPUTILS_H

#include <QQuickPaintedItem>
#include <QtCore>


class ScAppUtils : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(ScAppUtils)

public:
    explicit ScAppUtils(QQuickItem* parent = nullptr);
    virtual ~ScAppUtils() override;

    Q_INVOKABLE QString applicationFilePath();
    Q_INVOKABLE QString applicationDirPath();

};

#endif
