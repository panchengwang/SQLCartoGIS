#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView>
#include <QtWebEngineQuick>



int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QtWebEngineQuick::initialize();
    QtWebView::initialize();

    QGuiApplication app(argc,  argv);

    QQmlApplicationEngine engine;
    engine.addImportPath(QGuiApplication::applicationDirPath());
    engine.addImportPath("./");
    // qDebug() << QGuiApplication::applicationDirPath();
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
    Qt::QueuedConnection);
    engine.loadFromModule("SQLCartoDesktop", "Main");

    return app.exec();
}
