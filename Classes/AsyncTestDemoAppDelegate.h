//
//  AsyncTestDemoAppDelegate.h
//  AsyncTestDemo
//
//  Created by Robert Spychala on 10/30/09.
//

@interface AsyncTestDemoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

