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
