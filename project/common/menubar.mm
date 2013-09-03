#import "Utils.h"
#import <AppKit/NSApplication.h>
#import <AppKit/NSMenu.h>

@interface Target : NSObject { 
  NSMutableSet * _foo;
  NSMutableIndexSet * _enabledTags;
}

-(void)selected:(id) sender;
-(void)enable:(int) tag;
-(void)disable:(int) tag;
@end

@implementation Target {
  NSMutableSet * _foo;
  NSMutableIndexSet * _enabledTags;
}

-(id)init {
  self = [super init];
  _enabledTags = [NSMutableIndexSet indexSet];
  _foo = [NSMutableSet set];
  return self;
}

-(void)selected:(id) sender {
  NSLog(@"foofoo %d", [sender tag]);
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

  int AddMenuItemHelper(NSArray * parts, int index, NSMenu * parent) {
    NSString * title = [parts objectAtIndex: index];
    NSMenuItem * item = [parent itemWithTitle: title];
    NSMenu * submenu;
    
    if(!target)  {
      target = [[Target alloc] init];
      //[target make];
    }

    NSLog(@"adding item %@", title);
    if(!item) {
      item = [[NSMenuItem allocWithZone:[NSMenu menuZone]]
		  initWithTitle:title action:NULL keyEquivalent:@""];
      [parent addItem: item];
    }
    
    if([parts count] <= index + 1) {
      [item setTag: freeTagIndex];
      [item setTarget: target];
      [item setAction: @selector(selected:)];
      [item release];
      return freeTagIndex++;
    }

    submenu = [[NSMenu allocWithZone:[NSMenu menuZone]]
		  initWithTitle: title];
    [item setSubmenu: submenu];
    [item release];
    int tag = AddMenuItemHelper(parts, index + 1, submenu);
    [submenu release];
    return tag;
  }

  void EnableItem(int tag) {
    [target enable: tag];
  }

  void DisableItem(int tag) {
    [target disable: tag];
  }

  int AddMenuItem(const char * path) {
    NSArray * parts = [[NSString stringWithFormat:@"%s" , path]
			componentsSeparatedByString: @"/"];
    NSMenu * main = [NSApp mainMenu];
    return AddMenuItemHelper(parts, 0, main);
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
