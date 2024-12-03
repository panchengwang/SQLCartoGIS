#include "PcFileUtils.h"
#include <QFileInfo>


PcFileUtils::PcFileUtils()
{

}

QString PcFileUtils::path(const QString& filename)
{
    QUrl info(filename);
    return info.path();
}
