//
//  RNAppDelegate.h
//  Cost
//
//  Created by Rinik Vojto on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RNAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (retain) NSMutableDictionary *runningSince;
@property (retain) NSArray *costyApps;
@property (retain) NSStatusItem *statusItem;

- (void)checkApps;
- (BOOL)isAppRunning:(NSString *)name;

@end
