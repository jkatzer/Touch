//
//  TMBackendHelper.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import "TMBackendHelper.h"

@implementation TMBackendHelper

+ (TMBackendHelper *)helper {
  //THIS NEEDS TO BE SUBCLASSED!!!
  return nil;
}

-(NSString* )libraryName{
  //THIS NEEDS TO BE SUBCLASSED!!!
  return nil;
}

-(void)initialize {
  //THIS NEEDS TO BE SUBCLASSED!!!
}

-(void)setupWithDictionary:(NSDictionary*)dictionary {
  self.key = dictionary[@"key"];
  self.token = dictionary[@"token"];
}

-(void)trackEvent:(NSDictionary*)event {
  //THIS NEEDS TO BE SUBCLASSED!!!
}


@end
