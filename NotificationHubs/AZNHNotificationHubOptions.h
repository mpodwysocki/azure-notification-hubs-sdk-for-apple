//
//  AZNHNotificationHubOptions.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHNotificationHubOptions_h
#define AZNHNotificationHubOptions_h

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface AZNHNotificationHubOptions : NSObject

- (id)initWithAuthorizationOptions:(UNAuthorizationOptions)authorizationOptions;

@property(nonatomic, readonly) UNAuthorizationOptions authorizationOptions;

@end

#endif /* AZNHNotificationHubOptions_h */
