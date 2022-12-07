//
//  AZNHDebounceClient+Private.h
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#ifndef AZNHDebounceClient_Private_h
#define AZNHDebounceClient_Private_h

#include "AZNHDebounceClient.h"

@interface AZNHDebounceClient ()

@property (nonatomic) double interval;
@property (nonatomic, strong) NSTimer *debounceTimer;
@property (nonatomic) InstallationManagementHandler managementHandler;
@property (nonatomic) InstallationCompletionHandler completionHandler;

@end

#endif /* AZNHDebounceClient_Private_h */
