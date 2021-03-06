//
//  TMKeenBackendHelper.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Jason Katzer. All rights reserved.
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
  self.defaultCollection = @"Touch";
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

-(void)trackEvent:(NSDictionary *)event toCollection:(NSString *)collection error:(NSError *)error {
  [super trackEvent:event toCollection:collection error:error];

  [[KeenClient sharedClient] addEvent:event toEventCollection:self.defaultCollection error:&error];

  if (error) {
    [self log:error.description];
    [self.failedEvents addObject:event];
  }

}

-(void)uploadEvents{
  [[KeenClient sharedClient] uploadWithFinishedBlock:nil];
}

@end
