//
//  HRItem.m
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRItem.h"

@implementation HRItem

+ (Class)modelClass {
    return nil;
}

+ (instancetype) entityWithModelObject:(id) modelObject{
    return [[self alloc] initWithModelObject:modelObject];
}

+ (NSArray*) listEntityesWithArray:(NSArray*) modelObjects{
    NSMutableArray* result = [NSMutableArray new];
    for (id obj in modelObjects) {
        [result addObject:[self entityWithModelObject:obj]];
    }
    return result;
}

- (instancetype) initWithModelObject:(id<NSObject>) modelObject{
    self = [super init];
    if (self) {
        if (!modelObject){
            return self;
        }
        Class modelClass = [[self class] modelClass];
        NSAssert(!modelClass || [modelObject isKindOfClass:modelClass], @"incorrect class");
        _modelObject = modelObject;
    }
    return self;
}

@end
