/********************************************************************************
** Form generated from reading UI file 'remotecontrolbase.ui'
**
** Created: 
**      by: Qt User Interface Compiler version 4.8.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_REMOTECONTROLBASE_H
#define UI_REMOTECONTROLBASE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QGridLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QMainWindow>
#include <QtGui/QMenuBar>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QStatusBar>
#include <QtGui/QToolButton>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_RemoteControlBase
{
public:
    QWidget *centralwidget;
    QPushButton *connectButton;
    QWidget *layoutWidget;
    QGridLayout *gridLayout;
    QLabel *vehicleControlLabel;
    QSpacerItem *horizontalSpacer_4;
    QToolButton *forwardButton;
    QSpacerItem *horizontalSpacer_2;
    QToolButton *leftButton;
    QSpacerItem *horizontalSpacer_5;
    QToolButton *rightButton;
    QSpacerItem *horizontalSpacer;
    QToolButton *reverseButton;
    QSpacerItem *horizontalSpacer_3;
    QWidget *layoutWidget1;
    QGridLayout *gridLayout_2;
    QLabel *turretControlLabel;
    QSpacerItem *horizontalSpacer_9;
    QToolButton *turretUpButton;
    QSpacerItem *horizontalSpacer_10;
    QToolButton *turretLeftButton;
    QSpacerItem *horizontalSpacer_8;
    QToolButton *turretRightButton;
    QSpacerItem *horizontalSpacer_6;
    QToolButton *turretDownButton;
    QSpacerItem *horizontalSpacer_7;
    QPushButton *fireButton;
    QLabel *infoLabel;
    QMenuBar *menubar;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *RemoteControlBase)
    {
        if (RemoteControlBase->objectName().isEmpty())
            RemoteControlBase->setObjectName(QString::fromUtf8("RemoteControlBase"));
        RemoteControlBase->resize(466, 334);
        centralwidget = new QWidget(RemoteControlBase);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
        connectButton = new QPushButton(centralwidget);
        connectButton->setObjectName(QString::fromUtf8("connectButton"));
        connectButton->setGeometry(QRect(10, 10, 112, 26));
        layoutWidget = new QWidget(centralwidget);
        layoutWidget->setObjectName(QString::fromUtf8("layoutWidget"));
        layoutWidget->setGeometry(QRect(10, 50, 184, 202));
        gridLayout = new QGridLayout(layoutWidget);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        gridLayout->setContentsMargins(0, 0, 0, 0);
        vehicleControlLabel = new QLabel(layoutWidget);
        vehicleControlLabel->setObjectName(QString::fromUtf8("vehicleControlLabel"));
        vehicleControlLabel->setAlignment(Qt::AlignCenter);

        gridLayout->addWidget(vehicleControlLabel, 0, 0, 1, 3);

        horizontalSpacer_4 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout->addItem(horizontalSpacer_4, 1, 0, 1, 1);

        forwardButton = new QToolButton(layoutWidget);
        forwardButton->setObjectName(QString::fromUtf8("forwardButton"));
        QIcon icon;
        icon.addFile(QString::fromUtf8(":/vehicleIcons/up.png"), QSize(), QIcon::Normal, QIcon::Off);
        forwardButton->setIcon(icon);
        forwardButton->setIconSize(QSize(32, 32));
        forwardButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout->addWidget(forwardButton, 1, 1, 1, 1);

        horizontalSpacer_2 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout->addItem(horizontalSpacer_2, 1, 2, 1, 1);

        leftButton = new QToolButton(layoutWidget);
        leftButton->setObjectName(QString::fromUtf8("leftButton"));
        QIcon icon1;
        icon1.addFile(QString::fromUtf8(":/vehicleIcons/left.png"), QSize(), QIcon::Normal, QIcon::Off);
        leftButton->setIcon(icon1);
        leftButton->setIconSize(QSize(32, 32));
        leftButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout->addWidget(leftButton, 2, 0, 1, 1);

        horizontalSpacer_5 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout->addItem(horizontalSpacer_5, 2, 1, 1, 1);

        rightButton = new QToolButton(layoutWidget);
        rightButton->setObjectName(QString::fromUtf8("rightButton"));
        QIcon icon2;
        icon2.addFile(QString::fromUtf8(":/vehicleIcons/right.png"), QSize(), QIcon::Normal, QIcon::Off);
        rightButton->setIcon(icon2);
        rightButton->setIconSize(QSize(32, 32));
        rightButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout->addWidget(rightButton, 2, 2, 1, 1);

        horizontalSpacer = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout->addItem(horizontalSpacer, 3, 0, 1, 1);

        reverseButton = new QToolButton(layoutWidget);
        reverseButton->setObjectName(QString::fromUtf8("reverseButton"));
        QIcon icon3;
        icon3.addFile(QString::fromUtf8(":/vehicleIcons/down.png"), QSize(), QIcon::Normal, QIcon::Off);
        reverseButton->setIcon(icon3);
        reverseButton->setIconSize(QSize(32, 32));
        reverseButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout->addWidget(reverseButton, 3, 1, 1, 1);

        horizontalSpacer_3 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout->addItem(horizontalSpacer_3, 3, 2, 1, 1);

        layoutWidget1 = new QWidget(centralwidget);
        layoutWidget1->setObjectName(QString::fromUtf8("layoutWidget1"));
        layoutWidget1->setGeometry(QRect(239, 50, 184, 232));
        gridLayout_2 = new QGridLayout(layoutWidget1);
        gridLayout_2->setObjectName(QString::fromUtf8("gridLayout_2"));
        gridLayout_2->setContentsMargins(0, 0, 0, 0);
        turretControlLabel = new QLabel(layoutWidget1);
        turretControlLabel->setObjectName(QString::fromUtf8("turretControlLabel"));
        turretControlLabel->setAlignment(Qt::AlignCenter);

        gridLayout_2->addWidget(turretControlLabel, 0, 0, 1, 3);

        horizontalSpacer_9 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_2->addItem(horizontalSpacer_9, 1, 0, 1, 1);

        turretUpButton = new QToolButton(layoutWidget1);
        turretUpButton->setObjectName(QString::fromUtf8("turretUpButton"));
        QIcon icon4;
        icon4.addFile(QString::fromUtf8(":/vehicleIcons/up_turret.png"), QSize(), QIcon::Normal, QIcon::Off);
        turretUpButton->setIcon(icon4);
        turretUpButton->setIconSize(QSize(32, 32));
        turretUpButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout_2->addWidget(turretUpButton, 1, 1, 1, 1);

        horizontalSpacer_10 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_2->addItem(horizontalSpacer_10, 1, 2, 1, 1);

        turretLeftButton = new QToolButton(layoutWidget1);
        turretLeftButton->setObjectName(QString::fromUtf8("turretLeftButton"));
        QIcon icon5;
        icon5.addFile(QString::fromUtf8(":/vehicleIcons/left_turret.png"), QSize(), QIcon::Normal, QIcon::Off);
        turretLeftButton->setIcon(icon5);
        turretLeftButton->setIconSize(QSize(32, 32));
        turretLeftButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout_2->addWidget(turretLeftButton, 2, 0, 1, 1);

        horizontalSpacer_8 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_2->addItem(horizontalSpacer_8, 2, 1, 1, 1);

        turretRightButton = new QToolButton(layoutWidget1);
        turretRightButton->setObjectName(QString::fromUtf8("turretRightButton"));
        QIcon icon6;
        icon6.addFile(QString::fromUtf8(":/vehicleIcons/right_turret.png"), QSize(), QIcon::Normal, QIcon::Off);
        turretRightButton->setIcon(icon6);
        turretRightButton->setIconSize(QSize(32, 32));
        turretRightButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout_2->addWidget(turretRightButton, 2, 2, 1, 1);

        horizontalSpacer_6 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_2->addItem(horizontalSpacer_6, 3, 0, 1, 1);

        turretDownButton = new QToolButton(layoutWidget1);
        turretDownButton->setObjectName(QString::fromUtf8("turretDownButton"));
        QIcon icon7;
        icon7.addFile(QString::fromUtf8(":/vehicleIcons/down_turret.png"), QSize(), QIcon::Normal, QIcon::Off);
        turretDownButton->setIcon(icon7);
        turretDownButton->setIconSize(QSize(32, 32));
        turretDownButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);

        gridLayout_2->addWidget(turretDownButton, 3, 1, 1, 1);

        horizontalSpacer_7 = new QSpacerItem(58, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        gridLayout_2->addItem(horizontalSpacer_7, 3, 2, 1, 1);

        fireButton = new QPushButton(layoutWidget1);
        fireButton->setObjectName(QString::fromUtf8("fireButton"));

        gridLayout_2->addWidget(fireButton, 4, 0, 1, 3);

        infoLabel = new QLabel(centralwidget);
        infoLabel->setObjectName(QString::fromUtf8("infoLabel"));
        infoLabel->setGeometry(QRect(150, 10, 301, 21));
        RemoteControlBase->setCentralWidget(centralwidget);
        menubar = new QMenuBar(RemoteControlBase);
        menubar->setObjectName(QString::fromUtf8("menubar"));
        menubar->setGeometry(QRect(0, 0, 466, 21));
        RemoteControlBase->setMenuBar(menubar);
        statusbar = new QStatusBar(RemoteControlBase);
        statusbar->setObjectName(QString::fromUtf8("statusbar"));
        RemoteControlBase->setStatusBar(statusbar);

        retranslateUi(RemoteControlBase);
        QObject::connect(connectButton, SIGNAL(clicked()), RemoteControlBase, SLOT(serverConnect()));
        QObject::connect(forwardButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_forward()));
        QObject::connect(forwardButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_forward()));
        QObject::connect(leftButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_left()));
        QObject::connect(leftButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_left()));
        QObject::connect(reverseButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_reverse()));
        QObject::connect(reverseButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_reverse()));
        QObject::connect(rightButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_right()));
        QObject::connect(rightButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_right()));
        QObject::connect(fireButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_fire()));
        QObject::connect(fireButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_fire()));
        QObject::connect(turretDownButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_turret_down()));
        QObject::connect(turretDownButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_turret_down()));
        QObject::connect(turretLeftButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_turret_left()));
        QObject::connect(turretLeftButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_turret_left()));
        QObject::connect(turretRightButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_turret_right()));
        QObject::connect(turretRightButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_turret_right()));
        QObject::connect(turretUpButton, SIGNAL(pressed()), RemoteControlBase, SLOT(start_turret_up()));
        QObject::connect(turretUpButton, SIGNAL(released()), RemoteControlBase, SLOT(stop_turret_up()));

        QMetaObject::connectSlotsByName(RemoteControlBase);
    } // setupUi

    void retranslateUi(QMainWindow *RemoteControlBase)
    {
        RemoteControlBase->setWindowTitle(QApplication::translate("RemoteControlBase", "MainWindow", 0, QApplication::UnicodeUTF8));
        connectButton->setText(QApplication::translate("RemoteControlBase", "Connect", 0, QApplication::UnicodeUTF8));
        vehicleControlLabel->setText(QApplication::translate("RemoteControlBase", "Vehicle Controls", 0, QApplication::UnicodeUTF8));
        forwardButton->setText(QApplication::translate("RemoteControlBase", "W", 0, QApplication::UnicodeUTF8));
        leftButton->setText(QApplication::translate("RemoteControlBase", "A", 0, QApplication::UnicodeUTF8));
        rightButton->setText(QApplication::translate("RemoteControlBase", "D", 0, QApplication::UnicodeUTF8));
        reverseButton->setText(QApplication::translate("RemoteControlBase", "S", 0, QApplication::UnicodeUTF8));
        turretControlLabel->setText(QApplication::translate("RemoteControlBase", "Turret Controls", 0, QApplication::UnicodeUTF8));
        turretUpButton->setText(QApplication::translate("RemoteControlBase", "I", 0, QApplication::UnicodeUTF8));
        turretLeftButton->setText(QApplication::translate("RemoteControlBase", "J", 0, QApplication::UnicodeUTF8));
        turretRightButton->setText(QApplication::translate("RemoteControlBase", "L", 0, QApplication::UnicodeUTF8));
        turretDownButton->setText(QApplication::translate("RemoteControlBase", "K", 0, QApplication::UnicodeUTF8));
        fireButton->setText(QApplication::translate("RemoteControlBase", "FIRE (Enter)", 0, QApplication::UnicodeUTF8));
        infoLabel->setText(QApplication::translate("RemoteControlBase", "TextLabel", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class RemoteControlBase: public Ui_RemoteControlBase {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_REMOTECONTROLBASE_H
