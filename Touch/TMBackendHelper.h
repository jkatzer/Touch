//
//  TMBackendHelper.h
//  Touch
//
//  Created by Jason Katzer on 8/25/14.
//  Copyright (c) 2014 Versa.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Touch.h"

@interface TMBackendHelper : NSObject

+(TMBackendHelper* )helper;

-(void)initializeBackend;
-(void)trackEvent:(NSDictionary*)event;
-(void)setupWithDictionary:(NSDictionary*)dictionary;

-(NSString* )backendName;

-(void)log:(NSString*)logMessage;
-(void)uploadIsBeingExpired;

@property (nonatomic, assign) BOOL isSetup;
@property (nonatomic, retain) NSString* key;
@property (nonatomic, retain) NSString* token;
@property (nonatomic,retain) NSMutableArray* failedEvents;

@end
