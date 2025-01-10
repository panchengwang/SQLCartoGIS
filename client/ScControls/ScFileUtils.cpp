#include "ScFileUtils.h"
#include <QFileInfo>


ScFileUtils::ScFileUtils()
{

}

QString ScFileUtils::path(const QString& filename)
{
    QUrl info(filename);
    return info.path();
}

bool ScFileUtils::exist(const QString& filename)
{
    return QFile::exists(filename);
}

QString ScFileUtils::read(const QString& filename)
{
    QFile file(filename);
    file.open(QIODevice::Text | QIODevice::ReadOnly);
    QString content = file.readAll();
    file.close();
    return content;
}

void ScFileUtils::write(const QString& filename, const QString& content)
{
    QFile file(filename);
    file.open(QIODevice::Text | QIODevice::WriteOnly);
    file.write(QByteArray::fromStdString(content.toStdString()));
    file.close();
}
