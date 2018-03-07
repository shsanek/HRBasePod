//
//  HRKeyValueObserver.m
//  Test
//
//  Created by Alexander Shipin on 25/02/2018.
//  Copyright © 2018 HR. All rights reserved.
//

#import "HRKeyValueObserver.h"

@implementation HRKeyValueObserver

+ (instancetype) observObject:(id) object
                         keys:(NSArray<NSString*>*) keys
                observerBlock:(void (^)(id object,NSString* keyPath)) observerBlock{
    HRKeyValueObserver* result = [[self alloc] initWithObject:object keys:keys observerBlock:observerBlock];
    return result;
}

- (instancetype) initWithObject:(id) object
                           keys:(NSArray<NSString*>*) keys
                  observerBlock:(void (^)(id object,NSString* keyPath)) observerBlock{
    self = [super init];
    if (self) {
        _object = object;
        _keys = keys;
        _observerBlock = observerBlock;
        for (NSString* key in keys) {
            [object addObserver:self
                     forKeyPath:key
                        options:(NSKeyValueObservingOptionNew)
                        context:NULL];
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (self.object == object && [self.keys containsObject:keyPath]) {
        self.observerBlock(object, keyPath);
    }
}

- (void)dealloc {
    for (NSString* key in self.keys) {
        [self.object removeObserver:self forKeyPath:key];
    }
}

@end
