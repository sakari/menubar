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
