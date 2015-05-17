//
//  UIButton+TouchTracking.m
//  Touch
//
//  Created by Jason Katzer on 3/28/15.
//  Copyright (c) 2015 Versa.io. All rights reserved.
//

#import "UIButton+TouchTracking.h"
#import "Touch.h"
#import "NSObject+TMSwizzle.h"

@implementation UIButton (TouchTracking)
+(void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self tmswizzle:@selector(initWithFrame:) with:@selector(xxx_initWithFrame:)];
    [self tmswizzle:@selector(initWithCoder:) with:@selector(xxx_initWithCoder:)];
  });
}

- (instancetype)xxx_initWithFrame:(CGRect)frame {
  id result = [self xxx_initWithFrame:frame];
  if (result) {
    [result addTarget:self action:@selector(xxx_didTouchButton) forControlEvents:UIControlEventTouchUpInside];
  }
  return result;
}

-(instancetype)xxx_initWithCoder:(NSCoder *)aDecoder {
  id result = [self xxx_initWithCoder:aDecoder];
  if (result) {
    [result addTarget:self action:@selector(xxx_didTouchButton) forControlEvents:UIControlEventTouchUpInside];
  }
  return result;
}

- (void)xxx_didTouchButton {
  // TODO: do we want to actually add this action, or should only buttons with actions fire
  NSLog(@"BUTTON TOUCHED");
}
@end
