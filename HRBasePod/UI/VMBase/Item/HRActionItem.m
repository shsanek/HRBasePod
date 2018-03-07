//
//  HRActionItem.m
//  HR
//
//  Created by Alexander Shipin on 01/03/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "HRActionItem.h"

@implementation HRActionItem

+ (instancetype)actionItemWithBlock:(void (^)(id))action {
    HRActionItem* item = [self new];
    item.action = action;
    return item;
}

- (instancetype) updateAction:(void (^)(id item)) action{
    self.action = action;
    return self;
}

@end
