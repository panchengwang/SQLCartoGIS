#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore>
#include <QtGui>



int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

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


// #include <gdal.h>
// #include <ogr_geometry.h>
// #include <ogr_api.h>
// #include <ogr_core.h>
// #include <iostream>
// #include <vector>
// #include <gdal_frmts.h>


// int main() {
//     // 注册 GDAL 驱动
//     GDALAllRegister();

//     // --------------------------------
//     // 步骤 1：创建一个示例几何对象（如点），并导出为 WKB
//     // --------------------------------
//     OGRPoint originalPoint(1.0, 2.0);
//     size_t wkbSize = originalPoint.WkbSize();
//     std::vector<unsigned char> wkbBuffer(wkbSize);

//     // 导出几何对象到 WKB
//     unsigned char* wkb = new unsigned char[wkbSize];
//     OGRErr err = originalPoint.exportToWkb(wkb);
//     if (err != OGRERR_NONE) {
//         std::cerr << "导出 WKB 失败" << std::endl;
//         return 1;
//     }

//     // --------------------------------
//     // 步骤 2：从 WKB 数据重建几何对象
//     // --------------------------------
//     OGRGeometry* parsedGeometry = nullptr;
//     err = OGRGeometryFactory::createFromWkb(
//         wkb,           // WKB 数据指针
//         nullptr,                    // 空间参考（可设为 nullptr）
//         &parsedGeometry,
//         wkbSize
//     );

//     if (err != OGRERR_NONE || parsedGeometry == nullptr) {
//         std::cerr << "解析 WKB 失败" << std::endl;
//         return 1;
//     }

//     // --------------------------------
//     // 步骤 3：验证解析结果（示例：导出为 WKT）
//     // --------------------------------
//     char* wkt = nullptr;
//     parsedGeometry->exportToWkt(&wkt);
//     std::cout << "解析后的几何对象 WKT: " << wkt << std::endl;

//     // --------------------------------
//     // 清理资源
//     // --------------------------------
//     OGRFree(wkt);
//     OGRGeometryFactory::destroyGeometry(parsedGeometry);

//     return 0;
// }
