//
//  HRListContainer.m
//  HRViewModel
//
//  Created by Alexander Shipin on 20/02/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRListContainer.h"

@implementation HRListContainer

- (instancetype) initWithBaseObject:(id) baseObject{
    if (!baseObject) {
        return nil;
    }
    self = [super init];
    if (self) {
        _baseObject = baseObject;
        
        NSAssert([baseObject respondsToSelector:@selector(count)],
                 @"selector count not found");
        
        NSAssert([baseObject respondsToSelector:@selector(objectAtIndexedSubscript:)],
                 @"selector objectAtIndexedSubscript not found");
        
        NSAssert([baseObject respondsToSelector:@selector(countByEnumeratingWithState:objects:count:)],
                 @"selector countByEnumeratingWithState not found");
    }
    return self;
}

+ (instancetype) containerWithBaseObject:(id) baseObject{
    if (!baseObject) {
        return nil;
    }
    return [[self alloc] initWithBaseObject:baseObject];
}

#pragma mark -  base method
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained _Nullable [_Nonnull])buffer
                                    count:(NSUInteger)len{
    return [self.baseObject countByEnumeratingWithState:state
                                                objects:buffer
                                                  count:len];
}

- (NSUInteger) count{
    return self.baseObject.count;
}

- (id) objectAtIndexedSubscript:(NSUInteger) index{
    return [self.baseObject objectAtIndexedSubscript:index];
}


#pragma mark -
- (id) lastObject{
    if ([self.baseObject respondsToSelector:@selector(lastObject)]) {
        return self.baseObject.lastObject;
    } else if (self.baseObject.count > 0) {
        return self.baseObject[self.baseObject.count - 1];
    }
    return nil;
}

- (id) firstObject{
    if ([self.baseObject respondsToSelector:@selector(firstObject)]) {
        return self.baseObject.firstObject;
    } if (self.baseObject.count > 0) {
        return self.baseObject[0];
    }
    return nil;
}

- (NSUInteger)indexOfObject:(id)anObject{
    if ([self.firstObject respondsToSelector:@selector(indexOfObject:)]) {
        return [self.baseObject indexOfObject:anObject];
    }
    for (NSInteger i = 0; i < self.baseObject.count; i++) {
        if ([self.baseObject[i] isEqual:anObject]) {
            return i;
        }
    }
    return NSNotFound;
}

- (NSArray *)array {
    NSMutableArray* list = [NSMutableArray new];
    for (id obj in self) {
        [list addObject:obj];
    }
    return list;
}

@end
