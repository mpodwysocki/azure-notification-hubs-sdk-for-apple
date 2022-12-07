//
//  AZNHLogger.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHLogger_h
#define AZNHLogger_h

#import "AZNHConstants.h"

#define AZNHLog(_level, _tag, _message)                                        \
    [AZNHLogger logMessage:_message                                            \
                     level:_level                                              \
                       tag:_tag                                                \
                      file:__FILE__                                            \
                  function:__PRETTY_FUNCTION__                                 \
                      line:__LINE__]
#define AZNHLogAssert(tag, format, ...)                                        \
    AZNHLog(AZNHLogLevelAssert, tag, (^{                                       \
              return [NSString stringWithFormat:(format), ##__VA_ARGS__];      \
            }))
#define AZNHLogError(tag, format, ...)                                         \
    AZNHLog(AZNHLogLevelError, tag, (^{                                        \
              return [NSString stringWithFormat:(format), ##__VA_ARGS__];      \
            }))
#define AZNHLogWarning(tag, format, ...)                                       \
    AZNHLog(AZNHLogLevelWarning, tag, (^{                                      \
              return [NSString stringWithFormat:(format), ##__VA_ARGS__];      \
            }))
#define AZNHLogInfo(tag, format, ...)                                          \
    AZNHLog(AZNHLogLevelInfo, tag, (^{                                         \
              return [NSString stringWithFormat:(format), ##__VA_ARGS__];      \
            }))
#define AZNHLogDebug(tag, format, ...)                                         \
    AZNHLog(AZNHLogLevelDebug, tag, (^{                                        \
              return [NSString stringWithFormat:(format), ##__VA_ARGS__];      \
            }))
#define AZNHLogVerbose(tag, format, ...)                                       \
    AZNHLog(AZNHLogLevelVerbose, tag, (^{                                      \
              return [NSString stringWithFormat:(format), ##__VA_ARGS__];      \
            }))

NS_SWIFT_NAME(Logger)
@interface AZNHLogger : NSObject

+ (void)logMessage:(AZNHLogMessageProvider)messageProvider
             level:(AZNHLogLevel)loglevel
               tag:(NSString *)tag
              file:(const char *)file
          function:(const char *)function
              line:(uint)line;

@end

#endif /* AZNHLogger_h */
