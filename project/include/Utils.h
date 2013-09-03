#ifndef MENUBAR_H
#define MENUBAR_H


namespace menubar {
    int AddMenuItem(const char * path, const char * shortcut);
    void EnableItem(int tag );
    void DisableItem(int tag);
    void OnItem(const char * path);
    void OffItem(const char * path);
    void MixedItem(const char * path);
    void SetListener(void (*cb)(int));
}


#endif
