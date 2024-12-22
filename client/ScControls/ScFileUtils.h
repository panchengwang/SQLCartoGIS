#ifndef SCFILEUTILS_H
#define SCFILEUTILS_H

#include <QQuickItem>

class ScFileUtils : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
public:
    ScFileUtils();

    Q_INVOKABLE QString path(const QString& filename);

signals:

};

#endif // PCFILEUTILS_H
