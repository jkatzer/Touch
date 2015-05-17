//
//  UIControl+TouchTracking.m
//  Touch
//
//  Created by Jason Katzer on 1/25/15.
//  Copyright (c) 2015 Versa.io. All rights reserved.
//

#import "UIControl+TouchTracking.h"
#import "Touch.h"
#import "NSObject+TMSwizzle.h"

@implementation UIControl (TouchTracking)
+(void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self tmswizzle:@selector(sendAction:to:forEvent:) with:@selector(xxx_sendAction:to:forEvent:)];
  });
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
