/****************************************************************************
** Meta object code from reading C++ file 'remotecontrol.h'
**
** Created: Fri Feb 3 14:32:41 2012
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "remotecontrol.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'remotecontrol.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_RemoteControl[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      24,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x0a,
      58,   14,   14,   14, 0x0a,
      78,   14,   14,   14, 0x0a,
      94,   14,   14,   14, 0x0a,
     110,   14,   14,   14, 0x0a,
     125,   14,   14,   14, 0x0a,
     140,   14,   14,   14, 0x0a,
     156,   14,   14,   14, 0x0a,
     169,   14,   14,   14, 0x0a,
     181,   14,   14,   14, 0x0a,
     195,   14,   14,   14, 0x0a,
     208,   14,   14,   14, 0x0a,
     228,   14,   14,   14, 0x0a,
     247,   14,   14,   14, 0x0a,
     268,   14,   14,   14, 0x0a,
     288,   14,   14,   14, 0x0a,
     306,   14,   14,   14, 0x0a,
     323,   14,   14,   14, 0x0a,
     343,   14,   14,   14, 0x0a,
     362,   14,   14,   14, 0x0a,
     375,   14,   14,   14, 0x0a,
     398,  387,   14,   14, 0x0a,
     424,  417,   14,   14, 0x0a,
     441,  417,   14,   14, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_RemoteControl[] = {
    "RemoteControl\0\0"
    "displayError(QAbstractSocket::SocketError)\0"
    "connectionSuccess()\0serverConnect()\0"
    "start_forward()\0stop_forward()\0"
    "stop_reverse()\0start_reverse()\0"
    "start_left()\0stop_left()\0start_right()\0"
    "stop_right()\0start_turret_left()\0"
    "stop_turret_left()\0start_turret_right()\0"
    "stop_turret_right()\0start_turret_up()\0"
    "stop_turret_up()\0start_turret_down()\0"
    "stop_turret_down()\0start_fire()\0"
    "stop_fire()\0axis,value\0axisEvent(int,int)\0"
    "button\0buttonPress(int)\0buttonRelease(int)\0"
};

void RemoteControl::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        RemoteControl *_t = static_cast<RemoteControl *>(_o);
        switch (_id) {
        case 0: _t->displayError((*reinterpret_cast< QAbstractSocket::SocketError(*)>(_a[1]))); break;
        case 1: _t->connectionSuccess(); break;
        case 2: _t->serverConnect(); break;
        case 3: _t->start_forward(); break;
        case 4: _t->stop_forward(); break;
        case 5: _t->stop_reverse(); break;
        case 6: _t->start_reverse(); break;
        case 7: _t->start_left(); break;
        case 8: _t->stop_left(); break;
        case 9: _t->start_right(); break;
        case 10: _t->stop_right(); break;
        case 11: _t->start_turret_left(); break;
        case 12: _t->stop_turret_left(); break;
        case 13: _t->start_turret_right(); break;
        case 14: _t->stop_turret_right(); break;
        case 15: _t->start_turret_up(); break;
        case 16: _t->stop_turret_up(); break;
        case 17: _t->start_turret_down(); break;
        case 18: _t->stop_turret_down(); break;
        case 19: _t->start_fire(); break;
        case 20: _t->stop_fire(); break;
        case 21: _t->axisEvent((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 22: _t->buttonPress((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 23: _t->buttonRelease((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData RemoteControl::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject RemoteControl::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_RemoteControl,
      qt_meta_data_RemoteControl, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &RemoteControl::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *RemoteControl::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *RemoteControl::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_RemoteControl))
        return static_cast<void*>(const_cast< RemoteControl*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int RemoteControl::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 24)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 24;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
