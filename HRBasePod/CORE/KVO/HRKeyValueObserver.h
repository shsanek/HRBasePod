//
//  HRKeyValueObserver.h
//  Test
//
//  Created by Alexander Shipin on 25/02/2018.
//  Copyright © 2018 HR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRKeyValueObserver : NSObject

- (instancetype) initWithObject:(id) object
                           keys:(NSArray<NSString*>*) keys
                  observerBlock:(void (^)(id object,NSString* keyPath)) observerBlock;

+ (instancetype) observObject:(id) object
                         keys:(NSArray<NSString*>*) keys
                observerBlock:(void (^)(id object,NSString* keyPath)) observerBlock;

@property (nonatomic, weak, readonly) id object;
@property (nonatomic, strong, readonly) NSArray<NSString*>* keys;
@property (nonatomic, copy, readonly) void (^observerBlock)(id object,NSString* keyPath);

@end
