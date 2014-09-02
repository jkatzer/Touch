//
//  TMBackendHelper.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import "TMBackendHelper.h"

@implementation TMBackendHelper

static const NSString* libraryName = @"Touch";

+ (TMBackendHelper *)helper {
  //THIS NEEDS TO BE SUBCLASSED!!!
  return nil;
}

-(NSString* )backendName{
  //THIS NEEDS TO BE SUBCLASSED!!!
  return nil;
}

-(void)initialize {
  //THIS NEEDS TO BE SUBCLASSED!!!
}

-(void)setupWithDictionary:(NSDictionary*)dictionary {
  self.key = dictionary[@"key"];
  self.token = dictionary[@"token"];
}

-(void)trackEvent:(NSDictionary*)event {
  [self log:[NSString stringWithFormat:@"event: %@", event]];
}

-(void)log:(NSString *)logMessage {
  if ([Touch verbose]) {
    NSLog(@"%@: %@: %@", libraryName, self.backendName, logMessage);
  }
}

-(void)uploadIsBeingExpired {
  [self log:@"upload task being expired"];
}



@end
