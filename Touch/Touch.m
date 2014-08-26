//
//  Touch.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import "Touch.h"
#import "TMBackendHelper.h"

@implementation Touch {
  NSMutableDictionary* _backends;
  NSMutableDictionary* _unsentEvents;
}

+ (Touch *)touchManager
{
  static Touch *_shared = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _shared = [[self alloc] init];
  });

  return _shared;
}

+(void)setupBackend:(NSString*)backendName withId:(NSString*)backendId andToken:(NSString*)backendToken
{
  Touch* touchManager = [Touch touchManager];
  [touchManager setupBackend:backendName withId:backendId andToken:backendToken];
}

+(void)start
{
}

+(void)stop
{
}



//instance methods
-(id)helperForBackend:(NSString*)backendName
{
  Class backendHelper = NSClassFromString([NSString stringWithFormat:@"TM%@BackendHelper", backendName]);
  if ([backendHelper isSubclassOfClass:[TMBackendHelper class]]){
    return [[backendHelper class] helper];
  }
  return nil;
}




-(void)setupBackend:(NSString*)backendName withId:(NSString*)backendId andToken:(NSString*)backendToken
{
  if (_availableBackends[backendName] != nil) {
    if (_backends[backendName] == nil) {
      _backends[backendName] = [NSMutableDictionary dictionary];
    }

    if (_backends[backendName][backendId] == nil) {

    }
  }
}



@end
