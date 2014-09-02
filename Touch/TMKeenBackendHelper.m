//
//  TMKeenBackendHelper.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import "TMKeenBackendHelper.h"
#import <KeenClient/KeenClient.h>
#import <UIKit/UIKit.h>

@implementation TMKeenBackendHelper

+(TMBackendHelper *)helper {
  static TMBackendHelper *_sharedKeenHelper = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _sharedKeenHelper = [[self alloc] init];
  });
  return _sharedKeenHelper;
}

-(NSString*)backendName {
  return @"Keen";
}

-(void)initializeBackend {
  [KeenClient sharedClientWithProjectId:self.key andWriteKey:self.token andReadKey:self.readKey];
}

-(void)trackEvent:(NSDictionary *)event{
  [super trackEvent:event];

  NSError* err;

  [[KeenClient sharedClient] addEvent:event toEventCollection:self.defaultCollection error:&err];

  if (err) {
    [self log:err.description];
    [self.failedEvents addObject:event];
  }
}

-(void)uploadEvents{
  UIApplication* application = [UIApplication sharedApplication];

  UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^(void) {
    [self uploadIsBeingExpired];
  }];

  [[KeenClient sharedClient] uploadWithFinishedBlock:^(void) {
    [application endBackgroundTask:taskId];
  }];
}

@end
