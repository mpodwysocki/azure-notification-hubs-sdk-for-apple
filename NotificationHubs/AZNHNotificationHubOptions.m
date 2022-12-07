//
//  AZNHNotificationHubOptions.m
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#import "AZNHNotificationHubOptions.h"
#import <Foundation/Foundation.h>

@implementation AZNHNotificationHubOptions

- (id)init {
    if ((self = [super init])) {
        _authorizationOptions =
            (UNAuthorizationOptions)(UNAuthorizationOptionAlert |
                                     UNAuthorizationOptionSound |
                                     UNAuthorizationOptionBadge);
    }

    return self;
}

- (id)initWithAuthorizationOptions:
    (UNAuthorizationOptions)authorizationOptions {
    if ((self = [super init])) {
        _authorizationOptions = authorizationOptions;
    }

    return self;
}

@end
