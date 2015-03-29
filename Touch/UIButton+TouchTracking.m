//
//  UIButton+TouchTracking.m
//  Touch
//
//  Created by Jason Katzer on 3/28/15.
//  Copyright (c) 2015 Versa.io. All rights reserved.
//

#import "UIButton+TouchTracking.h"
#import "Touch.h"
#import <objc/runtime.h>

@implementation UIButton (TouchTracking)
+(void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self swizzle:@selector(initWithFrame:) with:@selector(xxx_initWithFrame:)];
    [self swizzle:@selector(initWithCoder:) with:@selector(xxx_initWithCoder:)];
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


- (instancetype)xxx_initWithFrame:(CGRect)frame {
  NSLog(@"creating a swizzled button");
  id result = [self xxx_initWithFrame:frame];
  if (result) {
    [result addTarget:self action:@selector(xxx_didTouchButton) forControlEvents:UIControlEventTouchUpInside];
  }
  return result;
}

-(instancetype)xxx_initWithCoder:(NSCoder *)aDecoder {
  NSLog(@"creating a swizzled button");
  id result = [self xxx_initWithCoder:aDecoder];
  if (result) {
    [result addTarget:self action:@selector(xxx_didTouchButton) forControlEvents:UIControlEventTouchUpInside];
  }
  return result;
}

- (void)xxx_didTouchButton {
  NSLog(@"BUTTON TOUCHED");
}

@end
