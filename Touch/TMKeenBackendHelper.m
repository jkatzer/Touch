//
//  TMKeenBackendHelper.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import "TMKeenBackendHelper.h"

@implementation TMKeenBackendHelper

+(TMBackendHelper *)helper {
  static TMBackendHelper *_sharedKeenHelper = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _sharedKeenHelper = [[self alloc] init];
  });
  return _sharedKeenHelper;
}

@end
