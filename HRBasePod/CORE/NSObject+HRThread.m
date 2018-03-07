//
//  NSObject+HRThread.m
//  Vivid
//
//  Created by Alexander Shipin on 27/02/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "NSObject+HRThread.h"

@implementation NSObject (HRThread)

- (void) hrAsyncRunInMainThread:(void (^)(id object)) block{
    if ([NSThread isMainThread]) {
        block(self);
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        block(strongSelf);
    });
}

- (void) hrSyncRunInMainThread:(void (^)(id object)) block{
    if ([NSThread isMainThread]) {
        block(self);
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_sync(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        block(strongSelf);
    });
}

@end
