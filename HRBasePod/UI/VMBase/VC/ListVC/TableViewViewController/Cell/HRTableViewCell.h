//
//  HRTableViewCell.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRUI.h"

@class HRItem;

@interface HRTableViewCell : UITableViewCell

- (void) fillWithItem:(HRItem*) item;

@end
