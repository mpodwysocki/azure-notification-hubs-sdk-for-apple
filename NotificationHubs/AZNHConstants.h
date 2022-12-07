//
//  AZNHConstants.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHConstants_h
#define AZNHConstants_h

#import <Foundation/Foundation.h>

/**
 * Service name for initialization.
 */
static NSString *const kAZNHServiceName = @"AzureNotificationHubs";

/**
 *  Log Levels
 */
typedef NS_ENUM(NSUInteger, AZNHLogLevel) {

    /**
     *  Logging will be very chatty
     */
    AZNHLogLevelVerbose = 2,

    /**
     *  Debug information will be logged
     */
    AZNHLogLevelDebug = 3,

    /**
     *  Information will be logged
     */
    AZNHLogLevelInfo = 4,

    /**
     *  Errors and warnings will be logged
     */
    AZNHLogLevelWarning = 5,

    /**
     *  Errors will be logged
     */
    AZNHLogLevelError = 6,

    /**
     * Only critical errors will be logged
     */
    AZNHLogLevelAssert = 7,

    /**
     *  Logging is disabled
     */
    AZNHLogLevelNone = 99
} NS_SWIFT_NAME(LogLevel);

typedef NSString * (^AZNHLogMessageProvider)(void)
    NS_SWIFT_NAME(LogMessageProvider);
typedef void (^AZNHLogHandler)(AZNHLogMessageProvider messageProvider,
                               AZNHLogLevel logLevel, NSString *tag,
                               const char *file, const char *function,
                               uint line) NS_SWIFT_NAME(LogHandler);

#endif /* AZNHConstants_h */
