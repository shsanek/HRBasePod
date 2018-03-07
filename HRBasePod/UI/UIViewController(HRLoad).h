//
//  UIViewController+Load.h
//  HR lib
//
//  Created by Alexander Shipin on 22/08/2017.
//  Copyright © 2017 HireRussians. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HRLoad)

+ (instancetype) hrViewController;
+ (instancetype) hrViewControllerWithViewModel:(id) viewModel;

@end
