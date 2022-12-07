//
//  AZNHLogger+Private.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHLogger_Private_h
#define AZNHLogger_Private_h

#import "AZNHLogger.h"

FOUNDATION_EXPORT AZNHLogHandler const AZNHDefaultLogHandler;

@interface AZNHLogger ()

+ (BOOL)isUserDefinedLogLevel;

/*
 * For testing only.
 */
+ (void)setIsUserDefinedLogLevel:(BOOL)isUserDefinedLogLevel;

+ (AZNHLogLevel)currentLogLevel;

+ (AZNHLogHandler)logHandler;

+ (void)setCurrentLogLevel:(AZNHLogLevel)currentLogLevel;

+ (void)setLogHandler:(AZNHLogHandler)logHandler;

@end

#endif /* AZNHLogger_Private_h */
