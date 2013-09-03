#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"


using namespace menubar;


static void setListener(value cb) {}
DEFINE_PRIM (setListener, 1);

static value addMenuItem(value path) {
    const char * str = val_get_string(path);
    int r = AddMenuItem(str);
    return alloc_int(r);
}
DEFINE_PRIM (addMenuItem, 1);

static void enableItem(value tag) {
    EnableItem(val_get_int(tag));
}
DEFINE_PRIM (enableItem, 1);

static void disableItem(value tag) {}
DEFINE_PRIM (disableItem, 1);

static value menubar_sample_method (value inputValue) {
	
	int returnValue = SampleMethod(val_int(inputValue));
	return alloc_int(returnValue);
	
}
DEFINE_PRIM (menubar_sample_method, 1);



extern "C" void menubar_main () {}
DEFINE_ENTRY_POINT (menubar_main);



extern "C" int menubar_register_prims () { return 0; }
