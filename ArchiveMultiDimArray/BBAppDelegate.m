//
//  BBAppDelegate.m
//  ArchiveMultiDimArray
//
//  Created by Bryan Boyko on 8/29/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "BBAppDelegate.h"
#import "BBMenuViewController.h"
#import "BBItemStore.h"
#import "BBBagStore.h"

@implementation BBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    BBMenuViewController *vc = [[BBMenuViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    BOOL success = [[BBBagStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"saved all bags");
    } else {
        NSLog(@"could not save bags");
    }
    BOOL alsoSuccess = [[BBItemStore sharedStore] saveChanges];
    if (alsoSuccess) {
        NSLog(@"saved all items");
    } else {
        NSLog(@"could not save items");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
