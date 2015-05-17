//
//  Touch.h
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Jason Katzer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Touch : NSObject

//the singleton
+(Touch *)touchManager;

//setting up a backend
+(void)setupBackend:(NSString*)backend withId:(NSString*)backendId andToken:(NSString*)backendToken;

//starting and stopping
+(void)start;
+(void)stop;

//additional uploading options
+(void)applicationDidEnterBackground:(UIApplication*)application;

//advanced features
+(void)setInterval:(NSInteger)interval;
+(BOOL)verbose;
+(void)setVerbose:(BOOL)isVerbose;
+(void)addEvent:(NSDictionary*)event;
+(void)addEvent:(NSDictionary*)event toCollection:(NSString*)collection error:(NSError*)error;

//super-advanced features
+(id)analyticsManagerForBackend:(NSString*)backend;



//instance methods
-(void)addEvent:(NSDictionary*)event;

//instance properties

@property (nonatomic, assign) BOOL verbose;
@property (nonatomic, assign) NSInteger interval;


@end
