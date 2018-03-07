//
//  __HRModelObjectSupproted.m
//  Vivid
//
//  Created by Alexander Shipin on 16/12/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "__HRModelObjectSupproted.h"
#import "NSObject+HRGetSubclass.h"

@implementation __HRModelObjectSupproted

+ (NSString*) primaryKey{
    return nil;
}
+ (NSArray<NSString*>*) loadIgnorePropertyNames{
    return nil;
}
+ (NSArray<NSString*>*) saveIgnorePropertyNames{
    return nil;
}
+ (NSArray<NSString*>*) descriptionIgnorePropertyNames{
    return nil;
}
+ (NSArray<NSString*>*) requiredPropertyNames{
    return nil;
}
+ (NSDictionary<NSString*,NSString*>*) dictionaryKeyForObject{
    return @{};
}

- (instancetype) initWithClass:(Class)currentClass {
    self = [super init];
    if (self) {
        NSArray<HRProperty*>* hrAllPropertys = [currentClass hrAllPropertys];
        _keys = [currentClass dictionaryKeyForObject];
        NSMutableArray* list = [NSMutableArray new];
        NSArray<NSString*>* ignoreNames = [currentClass loadIgnorePropertyNames];
        for (HRProperty* property in hrAllPropertys) {
            if (![property.parameters containsObject:@"LoadIgnore"] &&
                ![ignoreNames containsObject:property.name] &&
                !property.readonly) {
                [list addObject:property];
            }
        }
        _loadPropertyes = list;
        
        list = [NSMutableArray new];
        ignoreNames = [currentClass saveIgnorePropertyNames];
        for (HRProperty* property in hrAllPropertys) {
            if (![property.parameters containsObject:@"SaveIgnore"] &&
                ![ignoreNames containsObject:property.name]) {
                [list addObject:property];
            }
        }
        _savePropertyes = list;
        
        
        list = [NSMutableArray new];
        ignoreNames = [currentClass descriptionIgnorePropertyNames];
        for (HRProperty* property in hrAllPropertys) {
            if (![property.parameters containsObject:@"DescriptionIgnore"] &&
                ![ignoreNames containsObject:property.name]) {
                [list addObject:property];
            }
        }
        _descriptionPropertyes = list;
        
        list = [NSMutableArray new];
        ignoreNames = [currentClass requiredPropertyNames];
        for (HRProperty* property in hrAllPropertys) {
            if ([property.parameters containsObject:@"Required"] ||
                [ignoreNames containsObject:property.name]) {
                [list addObject:property];
            }
        }
        _requiredPropertyes = list;
    }
    return self;
}



@end
