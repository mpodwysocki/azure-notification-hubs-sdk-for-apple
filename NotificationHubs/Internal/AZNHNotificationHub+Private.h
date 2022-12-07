//
//  AZNHNotificationHub+Private.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHNotificationHub_Private_h
#define AZNHNotificationHub_Private_h

#import "AZNHNotificationHub.h"
#import "AZNHService+Private.h"
#import <Foundation/Foundation.h>
#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class AZNHConnection;
@class AZNHDebounceClient;
@class AZNHNotificationHubOptions;

@protocol AZNHCustomApplicationDelegate;
@protocol AZNHInstallationManagementDelegate;

#if TARGET_OS_OSX
@interface AZNHNotificationHub () <NSUserNotificationCenterDelegate>
#else
@interface AZNHNotificationHub ()
#endif

/**
 * Method registers notification settings and an application for remote notifications.
 */
- (void)registerForRemoteNotifications;

/**
 * Method to reset the singleton when running unit tests only. So calling sharedInstance returns a fresh instance.
 */
+ (void)resetSharedInstance;

@property (nonatomic, strong) AZNHNotificationHubOptions *options;

#if TARGET_OS_OSX

/**
 * The original NSUserNotificationCenterDelegate.
 */
@property(nonatomic) id<NSUserNotificationCenterDelegate> originalUserNotificationCenterDelegate;

/**
 * Method to return a context for observing delegate changes.
 */
+ (void *)userNotificationCenterDelegateContext;

/**
 * Observer to register user notification center delegate when application launches.
 */
- (void)applicationDidFinishLaunching:(NSNotification *)notification;

/**
 * Method that is called by NSUserNotificationCenter when its delegate changes.
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
#endif

NS_ASSUME_NONNULL_END

@end

#endif /* AZNHNotificationHub_Private_h */
