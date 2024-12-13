#include "ScAppUtils.h"
#include <QGuiApplication>

ScAppUtils::ScAppUtils(QQuickItem* parent)
    : QQuickItem(parent)
{

}


ScAppUtils::~ScAppUtils()
{

}

QString ScAppUtils::applicationFilePath()
{
    return QCoreApplication::applicationFilePath();
}

QString ScAppUtils::applicationDirPath()
{
    return QCoreApplication::applicationDirPath();
}
