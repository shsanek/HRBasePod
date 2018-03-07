//
//  HRIdentifierGenerator.m
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRIdentifierGenerator.h"
#import <objc/runtime.h>

@interface HRIdentifierGeneratorItem : NSObject

@property (nonatomic, assign) Class currentClass;
@property (nonatomic, strong) NSString* identifier;

@end

@implementation HRIdentifierGeneratorItem

@end

@interface HRIdentifierGenerator()

@property (nonatomic, strong) NSMutableArray* identifiers;
@property (nonatomic, strong) NSMutableArray<HRIdentifierGeneratorItem*>* items;

@end

@implementation HRIdentifierGenerator

- (instancetype)initWithPrefix:(NSString *)prefix {
    self = [self init];
    if (self) {
        _prefix = prefix;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _prefix = @"hr.";
        _items = [NSMutableArray new];
        _identifiers = [NSMutableArray new];
    }
    return self;
}

- (void) registerIdentifier:(NSString*) identifier{
    NSAssert(![self.identifiers containsObject:identifier], @"identifier already regist");
    [self.identifiers addObject:identifier];
}


- (NSString*) registerIdentifierForClass:(Class) object{
    NSString* currentIdentifier = [self.prefix stringByAppendingString:@"identifierGenerator"];
    NSInteger currentIndex = self.items.count ;
    NSString* resultIdentifier = nil;
    do {
        currentIndex++;
        resultIdentifier = [currentIdentifier stringByAppendingFormat:@"%d",(int)currentIndex];
    }while ([self.identifiers containsObject:resultIdentifier]);
    HRIdentifierGeneratorItem* item = [HRIdentifierGeneratorItem new];
    item.currentClass = object;
    item.identifier = resultIdentifier;
    [self.items addObject:item];
    return resultIdentifier;
}

- (NSString*) identifierForObject:(NSObject*) object{
    HRIdentifierGeneratorItem* resultItem = nil;
    NSInteger parent = 9999999;
    for (HRIdentifierGeneratorItem* item in self.items) {
        if ([object isKindOfClass:item.currentClass]) {
            Class currentClass = object.class;
            NSInteger count = 0;
            while (currentClass && currentClass != item.currentClass) {
                currentClass = class_getSuperclass(currentClass);
                count++;
            }
            if (parent > count) {
                parent = count;
                resultItem = item;
            }
        }
        if (parent == 0) {
            break;
        }
    }
    return resultItem.identifier;
}

@end
