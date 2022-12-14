//
//  AZNHInstallationTemplate.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHInstallationTemplate_h
#define AZNHInstallationTemplate_h

#import <Foundation/Foundation.h>
#import "AZNHTaggable.h"

/**
 * Represents an installation template.
 */
NS_SWIFT_NAME(InstallationTemplate)
@interface AZNHInstallationTemplate : NSObject <AZNHTaggable>

/**
 * The template body for notification payload which may contain placeholders to be filled in with actual data during the send operation
 */
@property(nonatomic, copy) NSString *body;

/**
 * A collection of headers applicable for MPNS-targeted notifications
 */
@property(nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *headers;

/**
 * Sets the header key and value.
 *
 * @param value The value of the header
 * @param key The name of the header.
 */
- (void)setHeader:(NSString *)value forKey:(NSString *)key;

/**
 * Removes the header for the given key.
 *
 * @param key The header to remove based upon the key.
 */
- (void)removeHeaderForKey:(NSString *)key;

/**
 * Gets the header value based upon the key.
 *
 * @param key The name of the header
 *
 * @returns The value of the header.
 */
- (NSString *)headerForKey:(NSString *)key;

@end

#endif /* AZNHInstallationTemplate_h */
