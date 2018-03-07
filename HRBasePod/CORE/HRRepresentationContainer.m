//
//  HRRepresentationContainer.m
//  HR
//
//  Created by Alexander Shipin on 18/12/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRRepresentationContainer.h"

@implementation HRRepresentationContainer

+ (NSArray<HRRepresentationContainer*>*) containersWithItems:(NSArray<id>*) itemList withModelObjects:(NSArray<id>*) modelList{
    NSMutableArray* list = [NSMutableArray new];
    for (int i = 0; i < itemList.count; i++) {
        [list addObject:[self containerWithItem:itemList[i] withModelObject:modelList[i]]];
    }
    return list;
}

+ (instancetype) containerWithItem:(id) item withModelObject:(id) modelObject{
    return [[self alloc] initWithItem:item withModelObject:modelObject];
}

- (instancetype) initWithItem:(id) item withModelObject:(id) modelObject{
    self = [super init];
    if (self) {
        _item = item;
        _model = modelObject;
    }
    return self;
}

@end
