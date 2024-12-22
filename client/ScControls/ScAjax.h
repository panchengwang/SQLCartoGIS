#ifndef SCAJAX_H
#define SCAJAX_H

#include <QObject>
#include <QQmlEngine>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QtCore>

class ScAjax : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(bool running READ running NOTIFY runningChanged FINAL)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged FINAL)

public:
    explicit ScAjax(QObject *parent = nullptr);
    virtual ~ScAjax();

    Q_INVOKABLE void post(const QString &url);
    Q_INVOKABLE void post(const QString &url, const QJsonObject& keyvals );
    Q_INVOKABLE void post(const QString &url, const QJsonObject& keyvals, const QString& file  );
    Q_INVOKABLE void post(const QString &url, const QJsonObject& keyvals, const QStringList& files);
    Q_INVOKABLE void post();
    Q_INVOKABLE void post(const QJsonObject& keyvals );
    Q_INVOKABLE void post(const QJsonObject& keyvals, const QString& file  );
    Q_INVOKABLE void post(const QJsonObject& keyvals, const QStringList& files);

    bool running();

    QString url();
    void setUrl(const QString& url);

protected:
    void close();

protected slots:
    void onErrorOccurred(QNetworkReply::NetworkError);
    void onFinished(QNetworkReply*);
signals:
    void runningChanged();
    void urlChanged();
    void finished(const QString& response);
    void error(const QString& message);

protected:
    QNetworkAccessManager *_manager;
    bool _running = false;
    QString _url = "";
    QString _errorMessage="";
};

#endif // SCAJAX_H
