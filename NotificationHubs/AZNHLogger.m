//
//  AZNHLogger.m
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#import "AZNHLogger+Private.h"
#import <Foundation/Foundation.h>

@implementation AZNHLogger

static AZNHLogLevel _currentLogLevel = AZNHLogLevelAssert;
static AZNHLogHandler currentLogHandler;
static BOOL _isUserDefinedLogLevel = NO;

AZNHLogHandler const AZNHDefaultLogHandler =
    ^(AZNHLogMessageProvider messageProvider, AZNHLogLevel logLevel,
      NSString *tag, __attribute__((unused)) const char *file,
      const char *function, uint line) {
      if (messageProvider) {
          if (_currentLogLevel > logLevel) {
              return;
          }

          NSString *level;
          switch (logLevel) {
          case AZNHLogLevelVerbose:
              level = @"VERBOSE";
              break;
          case AZNHLogLevelDebug:
              level = @"DEBUG";
              break;
          case AZNHLogLevelInfo:
              level = @"INFO";
              break;
          case AZNHLogLevelWarning:
              level = @"WARNING";
              break;
          case AZNHLogLevelError:
              level = @"ERROR";
              break;
          case AZNHLogLevelAssert:
              level = @"ASSERT";
              break;
          case AZNHLogLevelNone:
              return;
          }

          NSLog(@"[%@] %@: %@/%d %@", tag, level,
                [NSString stringWithCString:function
                                   encoding:NSUTF8StringEncoding],
                line, messageProvider());
      }
    };

+ (void)initialize {
    currentLogHandler = AZNHDefaultLogHandler;
}

+ (AZNHLogLevel)currentLogLevel {
    @synchronized(self) {
        return _currentLogLevel;
    }
}

+ (AZNHLogHandler)logHandler {
    @synchronized(self) {
        return currentLogHandler;
    }
}

+ (void)setCurrentLogLevel:(AZNHLogLevel)currentLogLevel {
    @synchronized(self) {
        _isUserDefinedLogLevel = YES;
        _currentLogLevel = currentLogLevel;
    }
}

+ (void)setLogHandler:(AZNHLogHandler)logHandler {
    @synchronized(self) {
        _isUserDefinedLogLevel = YES;
        currentLogHandler = logHandler;
    }
}

+ (void)logMessage:(AZNHLogMessageProvider)messageProvider
             level:(AZNHLogLevel)loglevel
               tag:(NSString *)tag
              file:(const char *)file
          function:(const char *)function
              line:(uint)line {
    if (currentLogHandler) {
        currentLogHandler(messageProvider, loglevel, tag, file, function, line);
    }
}

+ (BOOL)isUserDefinedLogLevel {
    return _isUserDefinedLogLevel;
}

+ (void)setIsUserDefinedLogLevel:(BOOL)isUserDefinedLogLevel {
    _isUserDefinedLogLevel = isUserDefinedLogLevel;
}

@end
