#ifndef ADD_H
#define ADD_H

#include <QObject>

class AddTransfer : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE goTerminal NOTIFY sig_getFromTerminal)

  public:
    AddTransfer();
    virtual ~AddTransfer();
    QString text();
    void goTerminal(QString gttext);
  signals:
    void sig_getFromTerminal(QString shellresult);
  public slots:
    void slot_getFromTerminal(QString sgftext);
  private:
    QString _text;
};

#endif // ADD_H
