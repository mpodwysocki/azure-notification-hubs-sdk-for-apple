//
//  AZNHInstallation.m
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/7/22.
//

#import <Foundation/Foundation.h>
#import "AZNHInstallation+Private.h"
#import "AZNHInstallationTemplate+Private.h"
#import "AZNHTagHelper.h"

@implementation AZNHInstallation

@synthesize installationId;
@synthesize expirationTime;
@synthesize pushChannel;
@synthesize tags;
@synthesize userId;
@synthesize templates;

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:installationId forKey:@"installationId"];
    [coder encodeObject:expirationTime forKey:@"expirationTime"];
    [coder encodeObject:pushChannel forKey:@"pushChannel"];
    [coder encodeObject:tags forKey:@"tags"];
    [coder encodeObject:userId forKey:@"userId"];
    [coder encodeObject:templates forKey:@"templates"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if ((self = [super init]) != nil) {
        installationId = [coder decodeObjectForKey:@"installationId"] ?: [[NSUUID UUID] UUIDString];
        expirationTime = [coder decodeObjectForKey:@"expirationTime"];
        pushChannel = [coder decodeObjectForKey:@"pushChannel"];
        tags = [coder decodeObjectForKey:@"tags"];
        userId = [coder decodeObjectForKey:@"userId"];
        templates = [coder decodeObjectForKey:@"templates"];
    }

    return self;
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        installationId = [[NSUUID UUID] UUIDString];
    }

    return self;
}

- (instancetype)initWithDeviceToken:(NSString *)deviceToken {
    if ((self = [self init]) != nil) {
        pushChannel = deviceToken;
    }

    return self;
}

+ (instancetype)createFromJSON:(NSDictionary *)json {
    AZNHInstallation *installation = [AZNHInstallation new];

    installation.installationId = json[@"installationId"];
    installation.pushChannel = json[@"pushChannel"];
    installation.tags = json[@"tags"];
    installation.userId = json[@"userId"];
    installation.templates = json[@"templates"];
    
    NSString *expiration = json[@"expirationTime"];
    if (expiration) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mmZ"];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        
        installation.expirationTime = [dateFormatter dateFromString:expiration];
    }

    return installation;
}

- (NSData *)toJSON {
    NSMutableDictionary *dictionary = [NSMutableDictionary
        dictionaryWithDictionary:@{@"installationId" : self.installationId, @"platform" : @"apns", @"pushChannel" : self.pushChannel}];
    
    if (expirationTime) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mmZ"];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        
        [dictionary setObject:[dateFormatter stringFromDate:expirationTime] forKey:@"expirationTime"];
    }

    if (tags && [tags count] > 0) {
        [dictionary setObject:[NSArray arrayWithArray:[self.tags allObjects]] forKey:@"tags"];
    }
    
    if (userId && [userId length] > 0) {
        [dictionary setObject:userId forKey:@"userId"];
    }

    if (templates && [templates count] > 0) {
        NSMutableDictionary *resultTemplates = [NSMutableDictionary new];
        for (NSString *key in [templates allKeys]) {
            AZNHInstallationTemplate *template = [templates objectForKey:key];
            [resultTemplates setObject:[template toDictionary] forKey:key];
        }
        [dictionary setObject:resultTemplates forKey:@"templates"];
    }

    return [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
}

#pragma mark Tags

- (BOOL)addTag:(NSString *)tag {
    return [self addTags:[NSArray arrayWithObject:tag]];
}

- (BOOL)addTags:(NSArray<NSString *> *)tagsToAdd {
    NSArray *invalidTags = [tagsToAdd filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, __unused NSDictionary *bindings) {
        return !isValidTag(evaluatedObject);
    }]];
                             
     if (invalidTags.count > 0) {
         return NO;
     }
    
    NSMutableSet *tmpTags = [NSMutableSet setWithSet:tags];
    [tmpTags addObjectsFromArray:tagsToAdd];

    tags = [tmpTags copy];
    return YES;
}

- (BOOL)removeTag:(NSString *)tag {
    return [self removeTags:[NSArray arrayWithObject:tag]];
}

- (BOOL)removeTags:(NSArray<NSString *> *)tagsToRemove {
    NSMutableSet *tmpTags = [NSMutableSet setWithSet:tags];

    BOOL hasTags = [[NSSet setWithArray:tagsToRemove] intersectsSet:tmpTags];
    if (!hasTags) {
        return NO;
    }

    [tmpTags minusSet:[NSSet setWithArray:tagsToRemove]];

    tags = [tmpTags copy];
    return YES;
}

- (void)clearTags {
    if (tags.count == 0) {
        return;
    }
    
    tags = [NSSet new];
}

#pragma mark Templates

- (BOOL)setTemplate:(AZNHInstallationTemplate *)template forKey:(NSString *)templateKey {
    NSMutableDictionary<NSString *, AZNHInstallationTemplate *> *tmpTemplates = [NSMutableDictionary dictionaryWithDictionary:self.templates];

    [tmpTemplates setObject:template forKey:templateKey];
    self.templates = tmpTemplates;
    return YES;
}

- (BOOL)removeTemplateForKey:(NSString *)templateKey {
    NSMutableDictionary<NSString *, AZNHInstallationTemplate *> *tmpTemplates = [NSMutableDictionary dictionaryWithDictionary:self.templates];

    if (![tmpTemplates objectForKey:templateKey]) {
        return NO;
    }

    [tmpTemplates removeObjectForKey:templateKey];
    self.templates = tmpTemplates;
    return YES;
}

- (AZNHInstallationTemplate *)templateForKey:(NSString *)templateKey {
    return [self.templates objectForKey:templateKey];
}

#pragma mark Equality

- (NSUInteger)hash {
    return [self.installationId hash] ^ [self.pushChannel hash] ^ [self.tags hash] ^ [self.templates hash] ^ [self.expirationTime hash];
}

- (BOOL)isEqualToAZNHInstallation:(AZNHInstallation *)installation {
    BOOL isInstallationsIdEqual = [self.installationId isEqualToString:installation.installationId];
    BOOL isExpirationTimeEqual = ((self.expirationTime != nil && installation.expirationTime != nil) || [self.expirationTime isEqualToDate:installation.expirationTime]);
    BOOL isTagsSetEqual = ((!self.tags && !installation.tags) || [self.tags isEqualToSet:installation.tags]);
    BOOL isUserIdEqual = ((!self.userId && !installation.userId) || [self.userId isEqualToString:installation.userId]);
    BOOL isTemplatesDictionaryEqual = ((!self.templates && !installation.templates) || [self.templates isEqualToDictionary:installation.templates]);
    return isInstallationsIdEqual && isExpirationTimeEqual && isTagsSetEqual && isUserIdEqual && isTemplatesDictionaryEqual;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![(NSObject *)object isKindOfClass:[AZNHInstallation class]]) {
        return NO;
    }

    return [self isEqualToAZNHInstallation:(AZNHInstallation *)object];
}

@end
