//
//  AZNHConnection.m
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#import "AZNHConnection.h"
#import "AZNHLogger.h"
#import <Foundation/Foundation.h>

@implementation AZNHConnection

- (instancetype)initWithConnectionString:(NSString *)connectionString {
    if ((self = [super init]) != nil) {
        NSDictionary *parsedConnectionString =
            [AZNHConnection parseConnectionString:connectionString];
        if (![self canInitWithConnectionDictionary:parsedConnectionString]) {
            return nil;
        }
    }

    return self;
}

+ (NSDictionary *)parseConnectionString:(NSString *)connectionString {
    NSArray *allField = [connectionString componentsSeparatedByString:@";"];

    NSMutableDictionary *result = [NSMutableDictionary dictionary];

    NSString *previousLeft = @"";
    for (unsigned long i = 0; i < [allField count]; i++) {
        NSString *currentField = (NSString *)[allField objectAtIndex:i];

        if ((i + 1) < [allField count]) {
            // if next field does not start with known name, this ';' will be
            // ignored
            NSString *lowerCaseNextField =
                [(NSString *)[allField objectAtIndex:(i + 1)] lowercaseString];
            if (!([lowerCaseNextField hasPrefix:@"endpoint="] ||
                  [lowerCaseNextField hasPrefix:@"sharedaccesskeyname="] ||
                  [lowerCaseNextField hasPrefix:@"sharedaccesskey="])) {
                previousLeft = [NSString
                    stringWithFormat:@"%@%@;", previousLeft, currentField];
                continue;
            }
        }

        currentField =
            [NSString stringWithFormat:@"%@%@", previousLeft, currentField];
        previousLeft = @"";

        NSArray *keyValuePairs =
            [currentField componentsSeparatedByString:@"="];
        if ([keyValuePairs count] < 2) {
            break;
        }

        NSString *keyName =
            [(NSString *)[keyValuePairs objectAtIndex:0] lowercaseString];

        NSString *keyValue =
            [currentField substringFromIndex:([keyName length] + 1)];
        if ([keyName isEqualToString:@"endpoint"]) {
            keyValue =
                [[AZNHConnection fixupEndpoint:[NSURL URLWithString:keyValue]
                                        scheme:@"https"] absoluteString];
        }

        [result setObject:keyValue forKey:keyName];
    }

    return result;
}

+ (NSURL *)fixupEndpoint:(NSURL *)endPoint scheme:(NSString *)scheme {
    NSString *absoluteString = [endPoint absoluteString];
    NSString *modifiedEndpoint = [NSString stringWithString:absoluteString];

    if (![modifiedEndpoint hasSuffix:@"/"]) {
        modifiedEndpoint = [NSString stringWithFormat:@"%@/", modifiedEndpoint];
    }

    NSInteger position = [modifiedEndpoint rangeOfString:@":"].location;
    if (position == NSNotFound) {
        modifiedEndpoint =
            [scheme stringByAppendingFormat:@"://%@", modifiedEndpoint];
    } else {
        modifiedEndpoint = [scheme
            stringByAppendingFormat:@"%@", [modifiedEndpoint
                                               substringFromIndex:position]];
    }

    return [NSURL URLWithString:modifiedEndpoint];
}

- (BOOL)canInitWithConnectionDictionary:(NSDictionary *)connectionDictionary {
    NSString *endpoint = [connectionDictionary objectForKey:@"endpoint"];
    if (endpoint) {
        _serviceEndPoint = [[NSURL alloc] initWithString:endpoint];
    }

    _sharedAccessKey = [connectionDictionary objectForKey:@"sharedaccesskey"];
    _sharedAccessKeyName =
        [connectionDictionary objectForKey:@"sharedaccesskeyname"];

    // validation
    if (_serviceEndPoint == nil || [_serviceEndPoint host] == nil) {
        AZNHLogError(
            kAZNHServiceName,
            @"Endpoint is missing or not in URL format in connectionString.");
        return NO;
    }

    if (_sharedAccessKey == nil || _sharedAccessKeyName == nil) {
        AZNHLogError(kAZNHServiceName,
                     @"Security information is missing in connectionString.");
        return NO;
    }

    return YES;
}

@end
