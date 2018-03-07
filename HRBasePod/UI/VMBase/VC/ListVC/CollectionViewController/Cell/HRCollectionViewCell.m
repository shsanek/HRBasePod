//
//  HRCollectionViewCell.m
//  Vivid
//
//  Created by Alexander Shipin on 21/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRCollectionViewCell.h"

@implementation HRCollectionViewCell

- (void)fillWithItem:(HRItem *)item {
    [self hrRemoveFromPoolAllObservers];
}

@end
