//
//  Touch.h
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Touch : NSObject

//the singleton
+(Touch *)touchManager;

//setting up a backend
+(void)setupBackend:(NSString*)backendName withId:(NSString*)backendId andToken:(NSString*)backendToken;

//starting and stopping
+(void)start;
+(void)stop;

//advanced features
+(void)setInterval:(NSInteger)interval;
+(void)setVerbose:(BOOL)isVerbose;
+(void)addEvent:(NSDictionary*)event;
+(void)addEvent:(NSDictionary*)event toCollection:(NSString*)collection error:(NSError*)error;

@end
