#include "PcAppUtils.h"
#include <QGuiApplication>

PcAppUtils::PcAppUtils(QQuickItem* parent)
    : QQuickItem(parent)
{

}


PcAppUtils::~PcAppUtils()
{

}

QString PcAppUtils::applicationFilePath()
{
    return QCoreApplication::applicationFilePath();
}

QString PcAppUtils::applicationDirPath()
{
    return QCoreApplication::applicationDirPath();
}
