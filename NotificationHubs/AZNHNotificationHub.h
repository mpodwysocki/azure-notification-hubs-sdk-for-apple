//
//  Header.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHNotificationHub_h
#define AZNHNotificationHub_h

#import "AZNHAbstractService+Private.h"
#import "AZNHNotificationHubOptions.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NotificationHub)
@interface AZNHNotificationHub : AZNHAbstractService

/**
 * Initializes the Notification Hub with the connection string from the Access
 * Policy, and Hub Name.
 *
 * @param connectionString The access policy connection string.
 * @param hubName The Azure Notification Hub name
 */
- (BOOL)startWithConnectionString:(NSString *)connectionString
                          hubName:(NSString *)hubName;

/**
 * Initializes the Notification Hub with the connection string from the Access
 * Policy, and Hub Name.
 *
 * @param connectionString The access policy connection string.
 * @param hubName The Azure Notification Hub name
 * @param options The Azure Notification Hubs options such as Authorization
 * Options.
 */
- (BOOL)startWithConnectionString:(NSString *)connectionString
                          hubName:(NSString *)hubName
                          options:(AZNHNotificationHubOptions *)options;

@end

NS_ASSUME_NONNULL_END

#endif /* AZNHNotificationHub_h */
