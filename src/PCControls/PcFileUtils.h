#ifndef PCFILEUTILS_H
#define PCFILEUTILS_H

#include <QQuickItem>

class PcFileUtils : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
public:
    PcFileUtils();

    Q_INVOKABLE QString path(const QString& filename);

signals:

};

#endif // PCFILEUTILS_H
