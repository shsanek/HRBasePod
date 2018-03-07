//
//  HRRepresentationContainer.h
//  HR
//
//  Created by Alexander Shipin on 18/12/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRRepresentationContainer<__covariant ItemType,__covariant ModelType>  : NSObject

+ (NSArray<HRRepresentationContainer*>*) containersWithItems:(NSArray<ItemType>*) itemList withModelObjects:(NSArray<ModelType>*) modelList;
+ (instancetype) containerWithItem:(ItemType) item withModelObject:(ModelType) modelObject;

@property (nonatomic, strong, readonly) ItemType item;
@property (nonatomic, strong, readonly) ModelType model;

- (instancetype) initWithItem:(ItemType) item withModelObject:(ModelType) modelObject;


@end
