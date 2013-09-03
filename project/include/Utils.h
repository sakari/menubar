#ifndef MENUBAR_H
#define MENUBAR_H


namespace menubar {
	int SampleMethod(int inputValue);
    int AddMenuItem(const char * path);
    void EnableItem(int tag );
    void DisableItem(int tag);
    void SetListener(void (*cb)(int));
}


#endif
