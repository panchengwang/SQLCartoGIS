#ifndef SCSPATIALDATABASE_H
#define SCSPATIALDATABASE_H

#include <QObject>
#include <QQmlEngine>
#include <QtSql>
#include <ogr_geometry.h>
#include "ScGeometryIO.h"

class ScSpatialDatabase : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScSpatialDatabase(QObject *parent = nullptr);
    virtual ~ScSpatialDatabase();

    bool isValid() const;

    QString errorMessage() const;

    bool execute(const QString& sql, const QVariantList& params);
    OGRGeometry* reproject(OGRGeometry* geo, int sourceSrid, int targetSrid);

protected:
    QSqlDatabase _db;
    QSqlQuery _query;

    bool _isValid;
    QString _errorMessage;
    ScGeometryIO _geometryIO;
signals:

private:
    Q_PROPERTY(bool isValid READ isValid CONSTANT FINAL)
};

#endif // SCSPATIALDATABASE_H
