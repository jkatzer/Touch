//
//  NSObject+TMSwizzle.h
//  Touch
//
//  Created by Jason Katzer on 5/17/15.
//  Copyright (c) 2015 Jason Katzer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TMSwizzle)

+(void)tmswizzle:(SEL)original with:(SEL)new;

@end
