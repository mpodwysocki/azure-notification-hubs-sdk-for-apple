//
//  Header.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHAbstractServicePrivate_h
#define AZNHAbstractServicePrivate_h

#import <Foundation/Foundation.h>
#import "AZNHAbstractService.h"
#import "AZNHConnection.h"
#import "AZNHDebounceClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface AZNHAbstractService ()

/**
 * Method converts NSData to NSString.
 *
 * @param token The push token.
 */
- (NSString *)convertTokenToString:(NSData *)token;

@property (nonatomic, strong, nullable) AZNHConnection *connection;
@property (nonatomic, strong) AZNHDebounceClient *debounceClient;
@property (nonatomic, nullable) NSString *pushChannel;

@end

NS_ASSUME_NONNULL_END

#endif /* AZNHAbstractServicePrivate_h */
