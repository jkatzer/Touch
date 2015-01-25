//
//  AppDelegate.m
//  TouchExampleApp
//
//  Created by Jason Katzer on 1/24/15.
//  Copyright (c) 2015 Versa.io. All rights reserved.
//

#import "AppDelegate.h"
#import "Touch.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.

  [Touch touchManager];
  [Touch setVerbose:YES];
  // including the write key for now so people can try the demo.
  // will have a public dashboard as well.
  [Touch setupBackend:@"Keen" withId:@"517bc950384331229b000002" andToken:@"83dd5537bfcad2a51653c9e3512a5cb7dc56fce2f8725fac3235f838a348b8a3b1f6d7ad5869e5ebd87466a21fbf7099d38278735842195f59c4dcc68d9774f63d31775c71cd0e4d0e034c956b74980f2e1b8487cb901e4bdca033bb5b8ff1a3c2bc14e8a51f1c59fedef21df461b81a"];
  [Touch start];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
