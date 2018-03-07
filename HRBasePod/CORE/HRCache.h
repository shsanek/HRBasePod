//
//  HRCache.h
//  Pods
//
//  Created by Alexander Shipin on 31/08/2017.
//
//

#import <Foundation/Foundation.h>

@class HRCache;

@protocol HRCacheDelegate <NSObject>

- (void) cache:(HRCache*) cache loadObjectWithKey:(id) key completionBlock:(void (^)(id obj,
                                                                                     NSInteger size,
                                                                                     NSError* error)) completionBlock;

- (void) cache:(HRCache*) cache didRemoveObject:(id) object withKey:(id) key;

@end

@interface HRCache <KeyType, ObjectType> : NSObject


@property (nonatomic, strong, readonly) dispatch_queue_t workQueue;
@property (nonatomic, assign, readonly) NSInteger currentSize;
@property (nonatomic, assign, readonly) NSInteger maxSize;
@property (nonatomic, weak, readonly) id<HRCacheDelegate> delegate;

- (instancetype) initWithWorkQueue:(dispatch_queue_t) workQueue
                           maxSize:(NSInteger) maxSize
                          delegate:(id<HRCacheDelegate>) delegate;

- (instancetype) initWithDelegate:(id<HRCacheDelegate>) delegate;

- (instancetype) initWithMaxSize:(NSInteger) maxSize
                        delegate:(id<HRCacheDelegate>) delegate;


- (ObjectType) requestObjectWithKey:(KeyType) key completionBlock:(void (^)(ObjectType obj,
                                                                            NSError* error,
                                                                            BOOL firstLoad)) completionBlock;

- (ObjectType) requestObjectWithKey:(KeyType) key preemptive:(BOOL) preemptive completionBlock:(void (^)(ObjectType obj,NSError* error, BOOL firstLoad)) completionBlock;

@end
