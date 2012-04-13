/********************************************************************************
** Form generated from reading UI file 'connectioninfobase.ui'
**
** Created: 
**      by: Qt User Interface Compiler version 4.8.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_CONNECTIONINFOBASE_H
#define UI_CONNECTIONINFOBASE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QDialog>
#include <QtGui/QDialogButtonBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_ConnectionInfoBase
{
public:
    QDialogButtonBox *buttonBox;
    QWidget *widget;
    QVBoxLayout *verticalLayout;
    QHBoxLayout *horizontalLayout_2;
    QLabel *ipLabel;
    QLineEdit *ipText;
    QHBoxLayout *horizontalLayout;
    QLabel *portLabel;
    QLineEdit *portText;

    void setupUi(QDialog *ConnectionInfoBase)
    {
        if (ConnectionInfoBase->objectName().isEmpty())
            ConnectionInfoBase->setObjectName(QString::fromUtf8("ConnectionInfoBase"));
        ConnectionInfoBase->resize(400, 163);
        buttonBox = new QDialogButtonBox(ConnectionInfoBase);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setGeometry(QRect(30, 100, 341, 32));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok);
        widget = new QWidget(ConnectionInfoBase);
        widget->setObjectName(QString::fromUtf8("widget"));
        widget->setGeometry(QRect(40, 20, 222, 64));
        verticalLayout = new QVBoxLayout(widget);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        verticalLayout->setContentsMargins(0, 0, 0, 0);
        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        ipLabel = new QLabel(widget);
        ipLabel->setObjectName(QString::fromUtf8("ipLabel"));

        horizontalLayout_2->addWidget(ipLabel);

        ipText = new QLineEdit(widget);
        ipText->setObjectName(QString::fromUtf8("ipText"));

        horizontalLayout_2->addWidget(ipText);


        verticalLayout->addLayout(horizontalLayout_2);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        portLabel = new QLabel(widget);
        portLabel->setObjectName(QString::fromUtf8("portLabel"));

        horizontalLayout->addWidget(portLabel);

        portText = new QLineEdit(widget);
        portText->setObjectName(QString::fromUtf8("portText"));

        horizontalLayout->addWidget(portText);


        verticalLayout->addLayout(horizontalLayout);


        retranslateUi(ConnectionInfoBase);
        QObject::connect(buttonBox, SIGNAL(accepted()), ConnectionInfoBase, SLOT(okClicked()));
        QObject::connect(buttonBox, SIGNAL(rejected()), ConnectionInfoBase, SLOT(reject()));

        QMetaObject::connectSlotsByName(ConnectionInfoBase);
    } // setupUi

    void retranslateUi(QDialog *ConnectionInfoBase)
    {
        ConnectionInfoBase->setWindowTitle(QApplication::translate("ConnectionInfoBase", "Dialog", 0, QApplication::UnicodeUTF8));
        ipLabel->setText(QApplication::translate("ConnectionInfoBase", "TextLabel", 0, QApplication::UnicodeUTF8));
        portLabel->setText(QApplication::translate("ConnectionInfoBase", "TextLabel", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ConnectionInfoBase: public Ui_ConnectionInfoBase {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_CONNECTIONINFOBASE_H
