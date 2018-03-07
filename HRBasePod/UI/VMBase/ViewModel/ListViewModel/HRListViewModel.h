//
//  HRListViewModel.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRViewModel.h"
#import "HRItemsListController.h"

@class HRItem;

@interface HRListViewModel : HRViewModel<HRItemsListControllerDelegate>

@property (nonatomic, strong) HRItemsListController* itemsListController;

- (NSInteger) numberOfSections;
- (NSInteger) numberOfItemInSection:(NSInteger) section;
- (HRItem*) itemAtIndex:(NSInteger) index inSection:(NSInteger) section;

- (void) didSelectItemAtIndex:(NSInteger) index inSection:(NSInteger) section;

@end
