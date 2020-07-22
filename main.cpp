#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>
#include <QTranslator>
#include <QProcess>

#include "add.h"

struct MArguments // Command Arguments
{
    bool LangCn; // true = lang is zh-CN
    bool FromMr; // true = is from Mr Noplay
};

MArguments MAppArgs = {false, false};

void parseArguments()
{
    // Get Command Arguments
    QStringList arguments = QCoreApplication::arguments();

    qDebug() << "Arguments : " << arguments;

    if (arguments.count() < 2)
        return;

    QString strJson = arguments.at(1);

    // Get Info from JSON
    QJsonParseError jsonError;
    QJsonDocument document = QJsonDocument::fromJson(strJson.toLocal8Bit(), &jsonError);
    if (jsonError.error != QJsonParseError::NoError)
        return;

    if (document.isObject())
    {
        QJsonObject obj = document.object();
        QJsonValue value;
        if (obj.contains("LangCn"))
        {
            value = obj.take("LangCn");
            if (value.isString())
                MAppArgs.LangCn = value == "true";
        }
        if (obj.contains("FromMr"))
        {
            value = obj.take("FromMr");
            if (value.isString())
                MAppArgs.FromMr = value == "true";
        }
    }
}

QString shell_in_main(QString text) {
    QProcess process;
    process.start(text);
    process.waitForFinished();
    return QString::fromLocal8Bit(process.readAllStandardOutput());
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    parseArguments();

    QString qmFilename;
    static QTranslator *translator;
    if (translator != NULL)
    {
        qApp->removeTranslator(translator);
        delete translator;
        translator = NULL;
    }
    translator = new QTranslator;
    QString runPath;
    if (!MAppArgs.LangCn) {
        runPath = ":/mrnoplay-blacklist-ui_en_US.qm";
    } else {
        runPath = ":/mrnoplay-blacklist-ui_zh_CN.qm";
    }
    if (translator->load(runPath))
    {
        qApp->installTranslator(translator);
    }

    if (!MAppArgs.FromMr)
    {
        const QUrl urlNotFromMr(QStringLiteral("qrc:/not-from-mr.qml"));
        engine.load(urlNotFromMr);
    }
    else
    {
        engine.load(url);
    }
    qmlRegisterType<AddTransfer>("AddTransfer", 1, 0, "AddTransfer");
    QString appname = "/Applications/Adobe Zii 2019 4.4.1.app";
    QString shellchar = "mdls -name kMDItemCFBundleIdentifier -r " + appname.replace(" ","\" \"");
    qDebug() << shell_in_main(shellchar);
    return app.exec();
}
