#import "Utils.h"
#import <AppKit/NSApplication.h>
#import <AppKit/NSMenu.h>

@interface Target : NSObject 
-(void)selected:(id) sender;
@end

@implementation Target
-(void)selected:(id) sender {
  NSLog(@"foofoo %d", [sender tag]);
}
@end

namespace menubar {

  static int freeTagIndex = 123;

  int AddMenuItemHelper(NSArray * parts, int index, NSMenu * parent) {
    NSString * title = [parts objectAtIndex: index];
    NSMenuItem * item = [parent itemWithTitle: title];
    NSMenu * submenu;


    NSLog(@"adding item %@", title);
    if(!item) {
      item = [[NSMenuItem allocWithZone:[NSMenu menuZone]]
		  initWithTitle:title action:NULL keyEquivalent:@""];
      [parent addItem: item];
    }
    
    if([parts count] <= index + 1) {
      [item setTag: freeTagIndex];
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

    target = [[[Target alloc] init] autorelease];

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
