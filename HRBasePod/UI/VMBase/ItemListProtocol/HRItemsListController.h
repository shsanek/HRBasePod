//
//  HRItemsListController.h
//  Vivid
//
//  Created by Alexander Shipin on 27/02/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRItem.h"

@class HRItemsListController;

@protocol HRItemsListControllerDelegate <NSObject>

- (void) didUpdateAllDataInItemsListController:(HRItemsListController*) itemsListController;

@end

@interface HRItemsListController : NSObject

@property (nonatomic, strong) id<HRItemsListControllerDelegate> delegate;
@property (nonatomic, strong) NSArray<NSArray<HRItem*>*>* items;

- (instancetype) initWithItems:(NSArray<NSArray<HRItem*>*>*) items;

- (NSInteger) numberOfSections;
- (NSInteger) numberOfItemsInSection:(NSInteger) section;
- (HRItem*) itemAtIndex:(NSInteger) index inSection:(NSInteger) section;

- (void) didSelectItemAtIndex:(NSInteger) index inSection:(NSInteger) section;

@end
