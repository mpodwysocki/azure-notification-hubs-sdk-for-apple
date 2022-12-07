//
//  AZNHConnection.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHConnection_h
#define AZNHConnection_h

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Connection)
@interface AZNHConnection : NSObject

- (instancetype)initWithConnectionString:(NSString *)connectionString;

@property(nonatomic, copy, readonly) NSString *sharedAccessKey;
@property(nonatomic, copy, readonly) NSString *sharedAccessKeyName;
@property(nonatomic, strong, readonly) NSURL *serviceEndPoint;

@end

#endif /* AZNHConnection_h */
