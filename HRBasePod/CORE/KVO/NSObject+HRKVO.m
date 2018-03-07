//
//  NSObject+HRKVO.m
//  Test
//
//  Created by Alexander Shipin on 25/02/2018.
//  Copyright © 2018 HR. All rights reserved.
//

#import "NSObject+HRKVO.h"
#import <objc/runtime.h>

static void *___HRKVO__observerPool;

@interface NSObject (__HRKVO)

- (NSMutableArray*) __observerPool;

@end

@implementation NSObject (__HRKVO)

- (NSMutableArray*) __observerPool {
    id result = objc_getAssociatedObject(self,&___HRKVO__observerPool);
    if (!result){
        result = [NSMutableArray new];
        [self set__observerPool:result];
    }
    return result;
}

- (void)set__observerPool:(NSMutableArray<HRKeyValueObserver*> *)__observerPool{
    objc_setAssociatedObject(self, &___HRKVO__observerPool, __observerPool, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation NSObject (HRKVO)

- (HRKeyValueObserver*)hrCreateObserverForObject:(id)object
                              keys:(NSArray<NSString *> *)keys
                     observerBlock:(void (^)(id, NSString *))observerBlock {
    HRKeyValueObserver* observ = [[HRKeyValueObserver alloc] initWithObject:object keys:keys observerBlock:observerBlock];
    [self hrAddInPoolObserver:observ];
    return observ;
}

- (HRKeyValueObserver *)hrCreateAndRunObserverForObject:(id)object
                                                     keys:(NSArray<NSString *> *)keys
                                            observerBlock:(void (^)(id, NSString *))observerBlock {
    HRKeyValueObserver* observ = [[HRKeyValueObserver alloc] initWithObject:object keys:keys observerBlock:observerBlock];
    [self hrAddInPoolAndRunObserver:observ];
    return observ;
}

- (void) hrAddInPoolObserver:(HRKeyValueObserver*) observer{
    [self.__observerPool addObject:observer];
}

- (void) hrAddInPoolAndRunObserver:(HRKeyValueObserver*) observer{
    [self hrAddInPoolObserver:observer];
    observer.observerBlock(observer.object, nil);
}

- (void) hrRemoveFromPoolObserver:(HRKeyValueObserver*) observer{
    [self.__observerPool removeObject:observer];
}

- (void) hrRemoveFromPoolAllObservers{
    [self.__observerPool removeAllObjects];
}

@end
