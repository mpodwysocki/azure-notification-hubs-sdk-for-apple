//
//  AZNHDebounceClient.m
//  NotificationHubs
//
//  Created by Matthew Podwysocki on 12/6/22.
//

#import <Foundation/Foundation.h>
#import "AZNHDebounceClient+Private.h"

@implementation AZNHDebounceClient

- (instancetype)initWithInterval:(double)interval {
    if ((self = [super init]) != nil) {
        _interval = interval;
    }
    
    return self;
}

- (void)runPipeline:(InstallationManagementHandler)managementHandler
  completionHandler:(InstallationCompletionHandler)completionHandler {
    if (!_debounceTimer) {
        [_debounceTimer invalidate];
    }
    
    _managementHandler = managementHandler;
    _completionHandler = completionHandler;
    
    _debounceTimer = [NSTimer scheduledTimerWithTimeInterval:_interval
                                                      target:self
                                                    selector:@selector(execute)
                                                    userInfo:nil
                                                     repeats:false];
    [[NSRunLoop mainRunLoop] addTimer:_debounceTimer forMode:NSRunLoopCommonModes];
}

- (void)execute {
    _managementHandler(_completionHandler);
}

@end
