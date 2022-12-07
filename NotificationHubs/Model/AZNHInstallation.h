//
//  AZNHInstallation.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHInstallation_h
#define AZNHInstallation_h

#import <Foundation/Foundation.h>
#import "AZNHTaggable.h"
#import "AZNHInstallationTemplate.h"

@class AZNHInstallationTemplate;

/**
 * The Azure Notification Hubs installation for a given device.
 */
NS_SWIFT_NAME(Installation)
@interface AZNHInstallation : NSObject <NSCoding, AZNHTaggable>

/**
 * Creates a new Installation from JSON.
 * @param json The JSON data to create the Installation object.
 */
+ (instancetype)createFromJSON:(NSDictionary *)json;

/**
 * The unique identifier for the installation
 */
@property(nonatomic, copy) NSString *installationId;

/**
 * The push token for the APNS Service
 */
@property(nonatomic, copy) NSString *pushChannel;

/**
 * The userID
 */
@property(nonatomic, copy) NSString *userId;

/**
 * The expiration for the installation
 */
@property(nonatomic, copy) NSDate *expirationTime;

/**
 * A collection ofinstallation templates.
 */
@property(nonatomic, readonly, copy) NSDictionary<NSString *, AZNHInstallationTemplate *> *templates;

/**
* Sets the template for the installation template for the given key.
*
* @param template The `MSInstallationTemplate` object containing the installation template data.
* @param key The key for the template.
*
* @returns YES if the template was added, else NO.
*
* @see MSInstallationTemplate
*/
- (BOOL)setTemplate:(AZNHInstallationTemplate *)template forKey:(NSString *)key;

/**
* Removes the installation template for the given key.
*
* @param key The key for the inistallation template.
*
* @returns YES if removed, else NO.
*/
- (BOOL)removeTemplateForKey:(NSString *)key;

/**
* Gets the installation template `MSInstallationTemplate` for the given key.
*
* @param key The key for the template.
*
* @returns The installation template instance
*
* @see MSInstallationTemplate
*/
- (AZNHInstallationTemplate *)templateForKey:(NSString *)key;

@end

#endif /* AZNHInstallation_h */
