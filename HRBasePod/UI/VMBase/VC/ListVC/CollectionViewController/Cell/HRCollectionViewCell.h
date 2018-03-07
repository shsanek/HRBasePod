//
//  HRCollectionViewCell.h
//  Vivid
//
//  Created by Alexander Shipin on 21/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRUI.h"

@class HRItem;

@interface HRCollectionViewCell : UICollectionViewCell

- (void) fillWithItem:(HRItem*) item;

@end
