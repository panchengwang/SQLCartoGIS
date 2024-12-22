#include "ScAjax.h"
#include <QtNetwork>
#include <QHttpMultiPart>
#include <QtCore>

ScAjax::ScAjax(QObject *parent)
    : QObject{parent}
{
    _manager = new QNetworkAccessManager(this);
    connect(_manager,SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));
}

ScAjax::~ScAjax()
{
    close();
}

void ScAjax::post(const QString& url)
{
    QJsonObject keyvals;
    QStringList files;
    post(url,keyvals,files);
}

void ScAjax::post(const QString& url, const QJsonObject& keyvals)
{
    QStringList files;
    post(url,keyvals,files);
}

void ScAjax::post(const QString& url, const QJsonObject& keyvals, const QString& file)
{
    QStringList files;
    files << file;
    post(url,keyvals,files);
}

void ScAjax::post(const QString& url, const QJsonObject& keyvals, const QStringList& files)
{
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QStringList keys = keyvals.keys();
    for(int i=0; i<keys.size(); i++) {

        QHttpPart textPart;
        QString fname = keys[i];
        QString fvalue = keyvals.value(keys[i]).toString();
        textPart.setHeader(QNetworkRequest::ContentDispositionHeader, QString("form-data; name=\"%1\"").arg(fname));
        textPart.setBody(fvalue.toLocal8Bit());
        multiPart->append(textPart);
    }


    for(int i=0; i<files.size(); i++){
        QHttpPart httppart;
        QFileInfo finfo(files[i]);
        httppart.setHeader(QNetworkRequest::ContentDispositionHeader, QString("form-data; name=\"file\"; filename=\"%1\"").arg(finfo.fileName()));
        httppart.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("application/octet-stream"));
        QFile *file = new QFile(files[i]);
        file->open(QIODevice::ReadOnly);
        httppart.setBodyDevice(file);
        file->setParent(multiPart);
        multiPart->append(httppart);
    }


    QUrl myurl(url);
    QNetworkRequest request(myurl);
    request.setAttribute(QNetworkRequest::UseCredentialsAttribute,false);
    QNetworkReply *reply = _manager->post(request, multiPart);
    connect(reply,SIGNAL(errorOccurred(QNetworkReply::NetworkError)), this, SLOT(onErrorOccurred(QNetworkReply::NetworkError)));

    multiPart->setParent(reply); // delete the multiPart with the reply

    _running = true;
    emit runningChanged();
}

void ScAjax::post()
{
    post(_url);
}

void ScAjax::post(const QJsonObject& keyvals)
{
    post(_url,keyvals);
}

void ScAjax::post(const QJsonObject& keyvals, const QString& file)
{
    post(_url,keyvals,file);
}

void ScAjax::post(const QJsonObject& keyvals, const QStringList& files)
{
    post(_url,keyvals,files);
}

bool ScAjax::running()
{
    return _running;
}

QString ScAjax::url()
{
    return _url;
}

void ScAjax::setUrl(const QString& url)
{
    _url = url;
}

void ScAjax::close()
{
    if(_manager){
        _manager->deleteLater();
    }
    _manager = NULL;
}

void ScAjax::onErrorOccurred(QNetworkReply::NetworkError)
{
    emit error("Network error! Please contact the administator!");
}

void ScAjax::onFinished(QNetworkReply *reply)
{

    _running = false;
    emit runningChanged();

    switch (reply->error()) {
        case QNetworkReply::NoError:
        {
            QJsonParseError parseError;
            QByteArray response = reply->readAll();
            emit finished(QString(response));
        }
        break;
        default:
            break;
    }
    reply->deleteLater();

}
