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
    Q_INVOKABLE bool exist(const QString& filename);
    Q_INVOKABLE QString read(const QString& filename);
    Q_INVOKABLE void write(const QString& filename, const QString& content);
signals:

};

#endif // PCFILEUTILS_H
