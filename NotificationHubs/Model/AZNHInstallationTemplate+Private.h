//
//  AZNHInstallationTemplate+Private.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/7/22.
//

#ifndef AZNHInstallationTemplate_Private_h
#define AZNHInstallationTemplate_Private_h

#import <Foundation/Foundation.h>
#import "AZNHInstallationTemplate.h"

@interface AZNHInstallationTemplate()

@property(nonatomic, copy) NSSet<NSString *> *tags;
@property(nonatomic, copy) NSDictionary<NSString *, NSString *> *headers;

// Serialize
- (NSDictionary *)toDictionary;

@end

#endif /* AZNHInstallationTemplate_Private_h */
