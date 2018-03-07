//
//  NSObject+HRThread.h
//  Vivid
//
//  Created by Alexander Shipin on 27/02/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HRThread)

- (void) hrAsyncRunInMainThread:(void (^)(id object)) block;
- (void) hrSyncRunInMainThread:(void (^)(id object)) block;

@end
