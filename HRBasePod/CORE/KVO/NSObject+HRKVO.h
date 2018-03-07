//
//  NSObject+HRKVO.h
//  Test
//
//  Created by Alexander Shipin on 25/02/2018.
//  Copyright © 2018 HR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRKeyValueObserver.h"

@interface NSObject (HRKVO)

- (HRKeyValueObserver*) hrCreateObserverForObject:(id) object
                                             keys:(NSArray<NSString*>*) keys
                                    observerBlock:(void (^)(id object,NSString* keyPath)) observerBlock;

- (HRKeyValueObserver*) hrCreateAndRunObserverForObject:(id) object
                                                   keys:(NSArray<NSString*>*) keys
                                          observerBlock:(void (^)(id object,NSString* keyPath)) observerBlock;

- (void) hrAddInPoolObserver:(HRKeyValueObserver*) observer;
- (void) hrAddInPoolAndRunObserver:(HRKeyValueObserver*) observer;

- (void) hrRemoveFromPoolObserver:(HRKeyValueObserver*) observer;

- (void) hrRemoveFromPoolAllObservers;

@end
