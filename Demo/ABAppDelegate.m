//
//  ABAppDelegate.m
//  HelloWorld
//
//  Created by Steven Hepting on 11/18/13.
//
//

#import "ABAppDelegate.h"
#import "ABDemoViewController.h"

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]

@implementation ABAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarHidden:YES];
    [[UINavigationBar appearance] setTintColor:COOKBOOK_PURPLE_COLOR];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ABDemoViewController *demo = [[ABDemoViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:demo];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
    
    return YES;
}

@end
