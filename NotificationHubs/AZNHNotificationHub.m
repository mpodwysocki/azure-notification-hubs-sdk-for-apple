//
//  AZNHNotificationHub.m
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#import "AZNHNotificationHub.h"
#import <Foundation/Foundation.h>

@implementation AZNHNotificationHub

#pragma mark Singleton

// Singleton
static AZNHNotificationHub *sharedInstance = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
      if (sharedInstance == nil) {
          sharedInstance = [self new];
      }
    });
    return sharedInstance;
}

+ (void)resetSharedInstance {
    // Resets the once_token so dispatch_once will run again
    onceToken = 0;
    sharedInstance = nil;
}

#pragma mark Initialization

- (BOOL)startWithConnectionString:(NSString *)connectionString
                          hubName:(NSString *)hubName {
    return YES;
}

- (BOOL)startWithConnectionString:(NSString *)connectionString
                          hubName:(NSString *)hubName
                          options:(AZNHNotificationHubOptions *)options {
    return YES;
}

@end
