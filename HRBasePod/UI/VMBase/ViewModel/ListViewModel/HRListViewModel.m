//
//  HRListViewModel.m
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRListViewModel.h"

@implementation HRListViewModel

- (NSInteger) numberOfSections{
    return [self.itemsListController numberOfSections];
}

- (NSInteger) numberOfItemInSection:(NSInteger) section{
    return [self.itemsListController numberOfItemsInSection:section];
}

- (HRItem*) itemAtIndex:(NSInteger) index inSection:(NSInteger) section{
    return [self.itemsListController itemAtIndex:index inSection:section];
}

- (void) didSelectItemAtIndex:(NSInteger) index inSection:(NSInteger) section{
    [self.itemsListController didSelectItemAtIndex:index inSection:section];
}

#pragma mark -
- (void)didUpdateAllDataInItemsListController:(HRItemsListController *)itemsListController {
    [self.updateDelegate didUpdateDataInViewModel:self];
}

@end
