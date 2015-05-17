//
//  Touch.m
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Jason Katzer. All rights reserved.
//

#import "Touch.h"
#import "TMBackendHelper.h"
#import "UIViewController+TouchTracking.h"
#import "UIResponder+TouchTracking.h"
#import "UIControl+TouchTracking.h"
#import "UIButton+TouchTracking.h"

@implementation Touch {
  NSMutableDictionary* _backends;
  NSMutableDictionary* _unsentEvents;
  NSDictionary* _availableBackends;
  NSTimer* _uploadTimer;
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

-(id)init
{
  self = [super init];
  if (self) {
    NSLog(@"Touch initialized");
    _backends = [NSMutableDictionary dictionary];
    //TODO: load in available backends from a PLIST
    _availableBackends = @{@"Keen":@"something"};
  }
  return self;
}


+(void)setupBackend:(NSString*)backendName withId:(NSString*)backendId andToken:(NSString*)backendToken
{
  Touch* touchManager = [Touch touchManager];
  [touchManager setupBackend:backendName withId:backendId andToken:backendToken];
}

+(void)start
{
  [[Touch touchManager] startUploading];
}

+(void)stop
{
  [[Touch touchManager] stopUploading];
}

+(void)applicationDidEnterBackground:(UIApplication*)application
{
  [[Touch touchManager] uploadEvents];
}


-(void)startUploading{
  _uploadTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(uploadEvents) userInfo:nil repeats:YES];
}

-(void)stopUploading
{
  if (_uploadTimer) {
    [_uploadTimer invalidate];
  }
}

+(BOOL)verbose {
  return [Touch touchManager].verbose;
}

+(void)setVerbose:(BOOL)isVerbose {
  [Touch touchManager].verbose = isVerbose;
}

+(void)setInterval:(NSInteger)interval {
  [Touch touchManager].interval = interval;
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
  if (self.verbose) {
    NSLog(@"Touch - setup backend");
  }
  if (_availableBackends[backendName] != nil) {
    if (_backends[backendName] == nil) {
      _backends[backendName] = [NSMutableDictionary dictionary];
    }

    if (_backends[backendName][backendId] == nil) {
       TMBackendHelper* backend = [self helperForBackend:backendName];
      backend.key = backendId;
      backend.token = backendToken;
      [backend initializeBackend];
      
      _backends[backendName][backendId] = backend;
    }
  }
}


-(void)addEvent:(NSDictionary*)event {
  for (NSDictionary* backendService in [_backends allValues]) {
    for (TMBackendHelper* backend in [backendService allValues]) {
      [backend trackEvent:event];
    }
  }
}

+(void)addEvent:(NSDictionary*)event {
  [[Touch touchManager] addEvent:event];
}


-(void)addEvent:(NSDictionary *)event toCollection:(NSString *)collection error:(NSError *)error {
  for (NSDictionary* backendService in [_backends allValues]) {
    for (TMBackendHelper* backend in [backendService allValues]) {
      [backend trackEvent:event toCollection:collection error:error];
    }
  }
}

+(void)addEvent:(NSDictionary *)event toCollection:(NSString *)collection error:(NSError *)error {
  [[Touch touchManager] addEvent:event toCollection:collection error:error];
}


-(void)uploadEvents
{
  if (self.verbose) {
    NSLog(@"Touch - uploading events");
  }

  for (NSDictionary* backendService in [_backends allValues]) {
    for (TMBackendHelper* backend in [backendService allValues]) {
      [backend uploadEvents];
    }
  }
}

@end
