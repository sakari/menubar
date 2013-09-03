#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"


using namespace menubar;

value * listener;


static void callback(int tag) {
    val_call1(*listener, alloc_int(tag));
}

static void setListener(value cb) {
    listener = alloc_root();
    *listener = cb;
    SetListener(callback);
}
DEFINE_PRIM (setListener, 1);

static value addMenuItem(value path, value shortcut) {
    const char * str = val_get_string(path);
    const char * key = val_is_null(shortcut) ? NULL : val_get_string(shortcut);
    int r = AddMenuItem(str, key);
    return alloc_int(r);
}
DEFINE_PRIM (addMenuItem, 2);

static void onItem(value path) {
    OnItem(val_get_string(path));
}
DEFINE_PRIM (onItem, 1);

static void offItem(value path) {
    OffItem(val_get_string(path));
}
DEFINE_PRIM (offItem, 1);

static void mixedItem(value path) {
    MixedItem(val_get_string(path));
}
DEFINE_PRIM (mixedItem, 1);

static void enableItem(value tag) {
    EnableItem(val_get_int(tag));
}
DEFINE_PRIM (enableItem, 1);

static void disableItem(value tag) {
    DisableItem(val_get_int(tag));
}
DEFINE_PRIM (disableItem, 1);

extern "C" void menubar_main () {}
DEFINE_ENTRY_POINT (menubar_main);



extern "C" int menubar_register_prims () { return 0; }
