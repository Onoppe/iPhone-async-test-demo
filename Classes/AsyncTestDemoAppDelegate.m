//
//  AsyncTestDemoAppDelegate.m
//  AsyncTestDemo
//
//  Created by Robert Spychala on 10/30/09.
//

#import "AsyncTestDemoAppDelegate.h"
#import "RootViewController.h"


@implementation AsyncTestDemoAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

