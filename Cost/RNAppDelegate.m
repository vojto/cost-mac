//
//  RNAppDelegate.m
//  Cost
//
//  Created by Rinik Vojto on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RNAppDelegate.h"

#define COSTY_APPS @"World of Warcraft"
#define HOURLY_RATE 50.0

@implementation RNAppDelegate

@synthesize window = _window;
@synthesize costyApps, runningSince, statusItem;

- (void)dealloc {
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
	self.statusItem = [[statusBar statusItemWithLength:NSVariableStatusItemLength] retain];
    
    [self.statusItem setTitle:@"..."];

    self.runningSince = [NSMutableDictionary dictionary];
    self.costyApps = [NSArray arrayWithObjects:COSTY_APPS, nil];
    
    [self checkApps];
}

- (void)checkApps {
    NSLog(@"Checking apps");
    
    for (NSString *costyApp in self.costyApps) {
        if ([self isAppRunning:costyApp]) {
            if (![self.runningSince objectForKey:costyApp])
                [self.runningSince setObject:[NSDate date] forKey:costyApp];
        } else {
            [self.runningSince removeObjectForKey:costyApp];
        }
    }
    
    if ([[self.runningSince allKeys] count] == 0) {
        [self.statusItem setTitle:@"..."];
    } else {
        NSString *lastApp = [[self.runningSince allKeys] lastObject];
        NSDate *startTime = [self.runningSince objectForKey:lastApp];
        NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:startTime];
        float minutes = seconds/60;
        
        float hourlyRate = HOURLY_RATE;
        float minuteRate = hourlyRate/60;
        
        float price = minutes * minuteRate;
        NSString *title = [NSString stringWithFormat:@"%@: $%0.2f", lastApp, price];
        [self.statusItem setTitle:title];
    }
    
    
    [self performSelector:@selector(checkApps) withObject:nil afterDelay:60];
}

- (BOOL)isAppRunning:(NSString *)name {
    for (NSRunningApplication *app in [[NSWorkspace sharedWorkspace] runningApplications]) {
        if([app.localizedName isEqualToString:name]) return YES;
    }
    return NO;
}

@end
