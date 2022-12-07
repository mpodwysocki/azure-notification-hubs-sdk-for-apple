//
//  AZNHInstallation+Private.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/7/22.
//

#ifndef AZNHInstallation_Private_h
#define AZNHInstallation_Private_h

#import <Foundation/Foundation.h>
#import "AZNHInstallation.h"

@interface AZNHInstallation()

- (instancetype)initWithDeviceToken:(NSString *)deviceToken;

@property(nonatomic, copy) NSDictionary<NSString *, AZNHInstallationTemplate *> *templates;
@property(nonatomic, copy) NSSet<NSString *> *tags;

@end

#endif /* AZNHInstallation_Private_h */
