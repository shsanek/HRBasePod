//
//  HRItem.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRCore.h"

@interface HRItem : NSObject

+ (Class) modelClass;
+ (instancetype) entityWithModelObject:(id) modelObject;
+ (NSArray*) listEntityesWithArray:(NSArray*) modelObjects;

@property (nonatomic, strong) id modelObject;

- (instancetype) initWithModelObject:(id) modelObject;

@end
