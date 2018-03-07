//
//  HRItemsListController.m
//  Vivid
//
//  Created by Alexander Shipin on 27/02/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "HRItemsListController.h"
#import "HRActionItem.h"

@interface HRItemsListController()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<HRItem*>*>* baseListItems;

@end

@implementation HRItemsListController

- (instancetype) initWithItems:(NSArray<NSArray<HRItem*>*>*) items{
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (NSArray<NSArray<HRItem *> *> *)items {
    return self.baseListItems;
}

- (void)setItems:(NSArray<NSArray<HRItem *> *> *)items {
    [self hrAsyncRunInMainThread:^(HRItemsListController* object) {
        NSMutableArray* list = [NSMutableArray new];
        for (NSArray<HRItem *>* i in items){
            [list addObject:[i mutableCopy]];
        }
        object.baseListItems = list;
    }];
}

- (void)setBaseListItems:(NSMutableArray<NSMutableArray<HRItem *> *> *)baseListItems {
    _baseListItems = baseListItems;
    [self.delegate didUpdateAllDataInItemsListController:self];
}

- (NSInteger) numberOfSections{
    return self.baseListItems.count;
}

- (NSInteger) numberOfItemsInSection:(NSInteger) section{
    return self.baseListItems[section].count;
}

- (HRItem*) itemAtIndex:(NSInteger) index inSection:(NSInteger) section{
    return self.baseListItems[section][index];
}

- (void) didSelectItemAtIndex:(NSInteger) index inSection:(NSInteger) section{
    HRActionItem* item = (id)self.items[section][index];
    if ([item isKindOfClass:[HRActionItem class]] && item.action) {
        item.action(item);
    }
}

@end
