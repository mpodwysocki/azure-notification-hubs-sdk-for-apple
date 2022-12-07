//
//  AZNHAbstractService.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHAbstractService_h
#define AZNHAbstractService_h

#import "AZNHConstants.h"
#import <AZNHTaggable.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AZNHAbstractService : NSObject <AZNHTaggable>

/**
 * Returns the singleton instance of the service.
 *
 * @return The singleton instance.
 */
+ (instancetype)sharedInstance;

#pragma mark - Installation Support

/**
 * The current push channel device token.
 */
@property(nonatomic, readonly, nullable) NSString *pushChannel;

/**
 * The current installation ID.
 */
@property(nonatomic, readonly, nullable) NSString *installationId;

/**
 * Clears the tags from the current installation.
 */
- (void)clearTags;

#pragma mark UserID support

/**
 * Represents the User ID for the application
 */
@property(nonatomic, copy) NSString *userId;

#pragma mark - Support

/**
 * The SDK's log level.
 */
@property(class, nonatomic) AZNHLogLevel logLevel;

/**
 * Set log handler.
 */
@property(class, nonatomic) AZNHLogHandler logHandler;

@end

NS_ASSUME_NONNULL_END

#endif /* AZNHAbstractService_h */
