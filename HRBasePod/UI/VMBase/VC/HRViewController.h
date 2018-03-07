//
//  HRViewController.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRUI.h"
#import "HRViewModel.h"

@class HRViewController;

@protocol HRViewControllerProtocol <NSObject>

- (void) setViewModel:(HRViewModel *)viewModel;
- (HRViewModel*) viewModel;

@end

@interface HRViewController : UIViewController<HRViewControllerProtocol,HRViewModelUpdateDelegate>

@property (nonatomic, assign, readonly) BOOL isNeedUpdate;

- (void) setNeedUpdate;
- (void) updateIfNeed;
- (void) allUpdate;

#pragma mark - Action
- (IBAction) backAction:(id)sender;
- (IBAction) dismissAction:(id)sender;

@end
