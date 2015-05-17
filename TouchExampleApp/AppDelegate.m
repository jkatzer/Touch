//
//  AppDelegate.m
//  TouchExampleApp
//
//  Created by Jason Katzer on 1/24/15.
//  Copyright (c) 2015 Jason Katzer. All rights reserved.
//

#import "AppDelegate.h"
#import "Touch.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [Touch touchManager];
  [Touch setVerbose:YES];
  // including the write key for now so people can try the demo.
  // will have a public dashboard as well.
  [Touch setupBackend:@"Keen" withId:@"517bc950384331229b000002" andToken:@"83dd5537bfcad2a51653c9e3512a5cb7dc56fce2f8725fac3235f838a348b8a3b1f6d7ad5869e5ebd87466a21fbf7099d38278735842195f59c4dcc68d9774f63d31775c71cd0e4d0e034c956b74980f2e1b8487cb901e4bdca033bb5b8ff1a3c2bc14e8a51f1c59fedef21df461b81a"];
  [Touch start];
  return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
  [Touch applicationDidEnterBackground:application];
}

@end
