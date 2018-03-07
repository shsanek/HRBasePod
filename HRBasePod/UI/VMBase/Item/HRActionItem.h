//
//  HRActionItem.h
//  HR
//
//  Created by Alexander Shipin on 01/03/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "HRItem.h"

@interface HRActionItem : HRItem

+ (instancetype) actionItemWithBlock:(void (^)(id item)) action;

@property (nonatomic, copy) void (^action)(id item);

- (instancetype) updateAction:(void (^)(id item)) action;

@end
