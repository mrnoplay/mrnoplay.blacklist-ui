#include "add.h"

#include <QProcess>
#include <QDebug>
#include "stdlib.h"

AddTransfer::AddTransfer()
{
  _text = "";
}

AddTransfer::~AddTransfer()
{

}

QString AddTransfer::text()
{
  return _text;
}

QString shell(QString text)
{
  QProcess process;
  QString shellchar;
#ifdef Q_OS_WIN32
  return text.right(text.length()-1);
#else
  shellchar = "mdls -name kMDItemCFBundleIdentifier -r " + text.replace(" ", "\" \"");
#endif
  process.start(shellchar);
  process.waitForFinished();
  return QString::fromLocal8Bit(process.readAllStandardOutput());
}

void shellWithArgumentsWithoutResponse(QString text, QStringList args)
{
  QProcess* process = new QProcess;
  process->start(text, args);
}

void AddTransfer::goTerminal(QString gttext)
{
  if (_text != gttext)
  {
    _text = gttext;
    emit sig_getFromTerminal(shell(_text));
  }
}

void AddTransfer::slot_getFromTerminal(QString sgftext)
{
  goTerminal(sgftext);
}

void AddTransfer::slot_openBlocking(QString way, QStringList listnames) {
  QStringList args;
  args << way << listnames;
  #ifdef Q_OS_WIN32
    QString pgmptr = _pgmptr;
    pgmptr = pgmptr.left(pgmptr.length() - 26);
    qDebug() << args;
    shellWithArgumentsWithoutResponse(pgmptr + "\\mbk.exe", args);
  #else
    // DO THINGS IN macOS
  #endif
}
