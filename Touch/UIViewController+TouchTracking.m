//
//  UIViewController+TouchTracking.m
//  Touch
//
//  Created by Jason Katzer on 1/25/15.
//  Copyright (c) 2015 Versa.io. All rights reserved.
//
//  Method Swizzling style from: http://nshipster.com/method-swizzling/
//

#import "UIViewController+TouchTracking.h"
#import "Touch.h"
#import "NSObject+TMSwizzle.h"

@implementation UIViewController (TouchTracking)

+(void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self tmswizzle:@selector(viewWillAppear:) with:@selector(xxx_viewWillAppear:)];
  });
}

- (void)xxx_viewWillAppear:(BOOL)animated {
  [self xxx_viewWillAppear:animated];
  NSLog(@"viewWillAppear: %@", self);
  [Touch addEvent:@{
                    @"event":@"viewWillAppear",
                    @"object":[NSString stringWithFormat:@"%@", self]
                    }];
}

@end
