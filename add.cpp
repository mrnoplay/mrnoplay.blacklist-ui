#include "add.h"

#include <QProcess>
#include <QDebug>

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
  return text;
#else
  shellchar = "mdls -name kMDItemCFBundleIdentifier -r " + text.replace(" ", "\" \"");
#endif
  process.start(shellchar);
  process.waitForFinished();
  return QString::fromLocal8Bit(process.readAllStandardOutput());
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
