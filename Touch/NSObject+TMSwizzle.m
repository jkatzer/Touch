//
//  NSObject+TMSwizzle.m
//  Touch
//
//  Created by Jason Katzer on 5/17/15.
//  Copyright (c) 2015 Jason Katzer. All rights reserved.
//

#import "NSObject+TMSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (TMSwizzle)
+(void)tmswizzle:(SEL)original with:(SEL)new {
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

@end
