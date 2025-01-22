#include "ScSpatialDatabase.h"
#include "ScGeometryIO.h"

ScSpatialDatabase::ScSpatialDatabase(QObject *parent)
    : QObject{parent}
{
    QString username = qgetenv("USER");
    if (username.isEmpty()){
        username = qgetenv("USERNAME");
    }

    _db = QSqlDatabase::addDatabase("QPSQL");
    _db.setHostName("127.0.0.1");
    _db.setDatabaseName(username);
    _db.setUserName(username);
    _db.setPassword("");

    _isValid = true;
    if(!_db.open()){
        _errorMessage = "Can not connect to local database";
        _isValid = false;
        return;
    }
    if(!execute("select sqlcarto_info()",QVariantList())){
        _isValid = false;
        return;
    }

}

ScSpatialDatabase::~ScSpatialDatabase()
{
    _db.close();
}

bool ScSpatialDatabase::isValid() const
{
    return _isValid;
}

QString ScSpatialDatabase::errorMessage() const
{
    return _errorMessage;
}

bool ScSpatialDatabase::execute(const QString& sql, const QVariantList& params)
{
    _query = QSqlQuery(_db);
    _query.prepare(sql);
    for(int i=0; i<params.size(); i++){
        _query.bindValue(i, params[i]);
    }
    if(!_query.exec()){
        _errorMessage = _query.lastError().databaseText();
        return false;
    }
    return true;
}

OGRGeometry* ScSpatialDatabase::reproject(OGRGeometry* geo, int sourceSrid, int targetSrid)
{
    QString wkb=_geometryIO.toWKB(geo);
    qDebug() << wkb;
    QString sql = QString("select st_astext(st_transform(st_setsrid('%1'::geometry,%2),%3))")
        .arg(wkb)
        .arg(sourceSrid)
        .arg(targetSrid);
    QVariantList params;

    if(!execute(sql,params)){
        qDebug() << _errorMessage;
        return NULL;
    }

    while(_query.next()){
        QString wkb = _query.record().value(0).toString();
        OGRGeometry* mygeo = _geometryIO.fromWKB(wkb);
        return mygeo;
    }
    return NULL;
}

