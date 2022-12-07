//
//  AZNHDebounceClient.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHDebounceClient_h
#define AZNHDebounceClient_h

NS_ASSUME_NONNULL_BEGIN

typedef void (^InstallationCompletionHandler)(NSError *_Nullable);
typedef void (^InstallationManagementHandler)(InstallationCompletionHandler _Nonnull);

@interface AZNHDebounceClient : NSObject

- (instancetype)initWithInterval:(double)interval;

- (void)runPipeline:(InstallationManagementHandler)managementHandler
  completionHandler:(InstallationCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END

#endif /* AZNHDebounceClient_h */
