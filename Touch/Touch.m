//
//  Touch.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import "Touch.h"

@implementation Touch

+ (Touch *)touchManager {
  static Touch *_shared = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _shared = [[self alloc] init];
  });

  return _shared;
}

+(void)setupBackend:(NSString*)backendName withId:(NSString*)backendId andToken:(NSString*)backendToken{

}

+(void)start{

}



@end
