//
//  UIViewController+TouchTracking.m
//  Touch
//
//  Created by Jason Katzer on 1/25/15.
//  Copyright (c) 2015 Versa.io. All rights reserved.
//

#import "UIViewController+TouchTracking.h"
#import <objc/runtime.h>

@implementation UIViewController (TouchTracking)

+(void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self swizzle:@selector(viewWillAppear:) with:@selector(xxx_viewWillAppear:)];
  });
}


+(void)swizzle:(SEL)original with:(SEL)new {
  Class class = [self class];

  Method originalMethod = class_getInstanceMethod(class, original);
  Method swizzledMethod = class_getInstanceMethod(class, new);

  BOOL didAddMethod =
  class_addMethod(class,
                  original,
                  method_getImplementation(swizzledMethod),
                  method_getTypeEncoding(swizzledMethod));

  if (didAddMethod) {
    class_replaceMethod(class,
                        new,
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}


- (void)xxx_viewWillAppear:(BOOL)animated {
  [self xxx_viewWillAppear:animated];
  NSLog(@"viewWillAppear: %@", self);
}

- (void)xxx_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self xxx_touchesBegan:touches withEvent:event];
}


@end
