//
//  HRSideMenuViewController.h
//  HR lib
//
//  Created by Shipin Alex on 20/10/15.
//  Copyright © 2015 HR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRKeyDefine.h"

HRIntefaceKey(hrMainMenuViewControllerSegueIdentifier);
HRIntefaceKey(hrSideMenuViewControllerSegueIdentifier);


@class HRSideMenuViewController;

@protocol HRSideMenuViewControllerDelegate <NSObject>

- (void) sideMenuViewController:(HRSideMenuViewController*) sideMenuVIewController openViewController:(UIViewController*) viewController;

@end


@interface UIViewController(HRSideMenu)

@property (nonatomic,weak,readonly) HRSideMenuViewController* hrSideMenuViewController;

@end


@interface HRSideMenuViewController : UIViewController

@property (nonatomic,weak) id<HRSideMenuViewControllerDelegate> delegate;

@property (nonatomic,strong) UIViewController* sideMenuViewController;
@property (nonatomic,strong) UIViewController* rootViewController;
@property (nonatomic,assign) IBInspectable BOOL isEnable;
@property (nonatomic,assign) IBInspectable BOOL shadow;
@property (nonatomic,assign, readonly) BOOL isShowMenu;
@property (nonatomic,assign) BOOL hiddenStatusBar;

- (void) openMenuWithAnimation:(BOOL) isAnimation;
- (void) closeMenuWithAnimation:(BOOL) isAnimation;
- (void) closeMenuWithAnimation:(BOOL) isAnimation completionBlock:(void (^)(void)) completionBlock;

@end
