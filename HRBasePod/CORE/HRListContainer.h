//
//  HRListContainer.h
//  HRViewModel
//
//  Created by Alexander Shipin on 20/02/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HRListContainerProtocol <NSFastEnumeration,NSObject>

- (NSUInteger) count;

- (NSUInteger)indexOfObject:(id)anObject;

- (id) lastObject;

- (id) firstObject;

- (id) objectAtIndexedSubscript:(NSUInteger) index;

@end


@interface HRListContainer<__covariant ObjectType>  : NSObject<NSFastEnumeration>

+ (instancetype) containerWithBaseObject:(id) baseObject;

@property (nonatomic, strong, readonly) id<HRListContainerProtocol> baseObject;

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, weak, readonly) ObjectType lastObject;
@property (nonatomic, weak, readonly) ObjectType firstObject;

@property (nonatomic, weak, readonly) NSArray<ObjectType>* array;

- (ObjectType) objectAtIndexedSubscript:(NSUInteger) index;
- (NSUInteger)indexOfObject:(ObjectType)anObject;

@end
