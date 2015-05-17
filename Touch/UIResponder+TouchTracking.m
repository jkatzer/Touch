//
//  UIResponder+TouchTracking.m
//  Touch
//
//  Created by Jason Katzer on 1/25/15.
//  Copyright (c) 2015 Jason Katzer. All rights reserved.
//

#import "UIResponder+TouchTracking.h"
#import "Touch.h"
#import "NSObject+TMSwizzle.h"

@implementation UIResponder (TouchTracking)
+(void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self tmswizzle:@selector(touchesBegan:withEvent:) with:@selector(xxx_touchesBegan:withEvent:)];
  });
}

- (void)xxx_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self xxx_touchesBegan:touches withEvent:event];
  NSLog(@"touchesBegan: %@", self);
  [Touch addEvent:@{
                    @"event":@"touchesBegan",
                    @"object":[NSString stringWithFormat:@"%@", self]
                    }];
}

@end
