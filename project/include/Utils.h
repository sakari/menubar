#ifndef MENUBAR_H
#define MENUBAR_H


namespace menubar {
    int AddMenuItem(const char * path, const char * shortcut);
    void EnableItem(int tag );
    void DisableItem(int tag);
    void SetListener(void (*cb)(int));
}


#endif
