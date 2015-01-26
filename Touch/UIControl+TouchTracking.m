//
//  UIControl+TouchTracking.m
//  Touch
//
//  Created by Jason Katzer on 1/25/15.
//  Copyright (c) 2015 Versa.io. All rights reserved.
//

#import "UIControl+TouchTracking.h"
#import "Touch.h"
#import <objc/runtime.h>

@implementation UIControl (TouchTracking)
+(void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self swizzle:@selector(sendAction:to:forEvent:) with:@selector(xxx_sendAction:to:forEvent:)];
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

-(void)xxx_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
  [self xxx_sendAction:action to:target forEvent:event];
  NSLog(@"sendAction: %@", self);
  [Touch addEvent:@{
                    @"event":@"sendAction",
                    @"object": @{
                        @"action":NSStringFromSelector(action),
                        @"target":[NSString stringWithFormat:@"%@", target],
                        @"event":[NSString stringWithFormat:@"%@", event]
                        }
                    }];
}

@end
