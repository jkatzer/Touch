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

  for (UITouch* touch in touches) {
    @try {
      NSString* phase = @"";
      switch (touch.phase) {
        case UITouchPhaseBegan:
          phase = @"UITouchPhaseBegan";
          break;
        case UITouchPhaseMoved:
          phase = @"UITouchPhaseMoved";
          break;
        case UITouchPhaseStationary:
          phase = @"UITouchPhaseStationary";
          break;
        case UITouchPhaseEnded:
          phase = @"UITouchPhaseEnded";
          break;
        case UITouchPhaseCancelled:
          phase = @"UITouchPhaseCancelled";
          break;
      }

      [Touch addEvent:@{
                        @"touch":@{
                            @"phase":phase,
                            @"view":@{
                                @"class":[NSString stringWithFormat:@"%@", touch.view.class],
                                @"frame":@[
                                    [NSNumber numberWithFloat:touch.view.frame.origin.x],
                                    [NSNumber numberWithFloat:touch.view.frame.origin.y],
                                    [NSNumber numberWithFloat:touch.view.frame.size.height],
                                    [NSNumber numberWithFloat:touch.view.frame.size.width]
                                  ],
                                @"tag":[NSNumber numberWithFloat:touch.view.tag],
                                @"accessibilityLabel":[NSString stringWithFormat:@"%@", touch.view.accessibilityLabel],
                                @"class":[NSString stringWithFormat:@"%@", touch.view.superview]
                                }
                            }
                        }];
    }
    @catch (NSException *exception) {

    }

  }

}

@end
