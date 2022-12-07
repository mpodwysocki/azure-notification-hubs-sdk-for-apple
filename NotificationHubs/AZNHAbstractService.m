//
//  AZNHAbstractService.m
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#import "AZNHAbstractService+Private.h"
#import "AZNHLogger+Private.h"
#import <Foundation/Foundation.h>

@implementation AZNHAbstractService

@synthesize tags;

#pragma mark - Installation methods

+ (instancetype)sharedInstance {
    return nil;
}

#pragma mark - Tags Management

- (BOOL)addTag:(NSString *)tag {
    return [self addTags:[NSArray arrayWithObject:tag]];
}

- (BOOL)addTags:(NSArray<NSString *> *)tags {
    return YES;
}

- (BOOL)removeTag:(NSString *)tag {
    return [self removeTags:[NSArray arrayWithObject:tag]];
}

- (BOOL)removeTags:(NSArray<NSString *> *)tags {
    return YES;
}

- (void)clearTags {
}

#pragma mark - Helpers

- (NSString *)convertTokenToString:(NSData *)token {
    if (!token) {
        return nil;
    }
    const unsigned char *dataBuffer = token.bytes;
    NSMutableString *stringBuffer =
        [NSMutableString stringWithCapacity:(token.length * 2)];
    for (NSUInteger i = 0; i < token.length; ++i) {
        [stringBuffer appendFormat:@"%02x", dataBuffer[i]];
    }
    return [NSString stringWithString:stringBuffer];
}

#pragma mark - Support

+ (AZNHLogLevel)logLevel {
    return AZNHLogger.currentLogLevel;
}

+ (void)setLogLevel:(AZNHLogLevel)logLevel {
    AZNHLogger.currentLogLevel = logLevel;

    // The logger is not set at the time of swizzling but now may be a good time
    // to flush the traces.
    //[AZNHDelegateForwarder flushTraceBuffer];
}

+ (AZNHLogHandler)logHandler {
    return AZNHLogger.logHandler;
}

+ (void)setLogHandler:(AZNHLogHandler)logHandler {
    AZNHLogger.logHandler = logHandler;
}

@end
