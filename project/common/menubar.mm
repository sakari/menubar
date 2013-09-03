#import "Utils.h"
#import <AppKit/NSApplication.h>
#import <AppKit/NSMenu.h>

typedef void (*Callback)(int tag);

@interface Target : NSObject { 
  NSMutableIndexSet * _enabledTags;
  Callback _cb;
}

-(void)selected:(id) sender;
-(void)enable:(int) tag;
-(void)disable:(int) tag;
-(Target*)setListener:(Callback) cb;
@end

@implementation Target {
  NSMutableIndexSet * _enabledTags;
  Callback _cb;
}

- (BOOL)validateMenuItem:(NSMenuItem *)item {
  return [_enabledTags containsIndex: [item tag]];
}

-(id)init {
  self = [super init];
  _enabledTags = [NSMutableIndexSet indexSet];
  return self;
}

-(Target*)setListener:(Callback) cb {
  _cb = cb;
}

-(void)selected:(id) sender {
  if(!_cb) return;
  _cb([sender tag]);
}

-(void)enable:(int) tag {
  [_enabledTags addIndex: tag];
}

-(void)disable:(int) tag {
  [_enabledTags removeIndex: tag];
}
@end

namespace menubar {

  static int freeTagIndex = 123;
  static Target * target;
  static void (^callback) (int);

  void SetListener(Callback cb) {
    if(!target)  {
      target = [[Target alloc] init];
    }

    [target setListener: cb];
  }

  int AddMenuItemHelper(NSArray * parts, int index, NSMenu * parent, NSString * shortcut) {
    NSString * title = [parts objectAtIndex: index];
    NSMenuItem * item = [parent itemWithTitle: title];
    NSMenu * submenu;

    if(!target)  {
      target = [[Target alloc] init];
    }

    if(!item) {
      item = [[NSMenuItem allocWithZone:[NSMenu menuZone]]
		  initWithTitle:title 
			 action:NULL
		  keyEquivalent:@""];
      [parent addItem: item];
    }
    
    if([parts count] <= index + 1) {
      [item setTag: freeTagIndex];
      [item setTarget: target];
      [item setAction: @selector(selected:)];
      [item setKeyEquivalent: shortcut];
      return freeTagIndex++;
    }
    
    submenu = [item submenu];
    if(!submenu) {
      submenu = [[NSMenu allocWithZone:[NSMenu menuZone]]
		  initWithTitle: title];
      [item setSubmenu: submenu];
    }
    int tag = AddMenuItemHelper(parts, index + 1, submenu, shortcut);
    return tag;
  }

  void EnableItem(int tag) {
    [target enable: tag];
  }

  void DisableItem(int tag) {
    [target disable: tag];
  }

  int AddMenuItem(const char * path, const char * shortcut) {
    NSString * key = shortcut ? 
      [NSString stringWithFormat:@"%s", shortcut] : @"";
    NSArray * parts = [[NSString stringWithFormat:@"%s" , path]
			componentsSeparatedByString: @"/"];
    NSMenu * main = [NSApp mainMenu];
    return AddMenuItemHelper(parts, 0, main, key);
  }

  int SampleMethod(int inputValue) {
    NSMenu *newMenu;
    NSMenuItem *newItem;
    NSMenuItem * submenuItem;
    Target * target;

    target = [[Target alloc] init];

    submenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]]
		    initWithTitle:@"Item" action:NULL keyEquivalent:@""];

    [submenuItem setTag: 123];
    [submenuItem setEnabled: true];
    [submenuItem setTarget: target];
    [submenuItem setAction: @selector(selected:)];

    newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]]
		initWithTitle:@"Flashy" action:NULL keyEquivalent:@""];
    [newItem setEnabled: true];

    newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]]
		initWithTitle:@"Flashy"];
    [newMenu setAutoenablesItems: NO];
    [newMenu addItem: submenuItem];

    [submenuItem release];

    [newItem setSubmenu:newMenu];
    [newMenu release];

    [[NSApp mainMenu] addItem:newItem];
    [newItem release];

    return inputValue * 100;
  }
}
