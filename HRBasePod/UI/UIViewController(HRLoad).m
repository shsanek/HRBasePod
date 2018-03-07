//
//  UIViewController+Load.m
//  HR lib
//
//  Created by Alexander Shipin on 22/08/2017.
//  Copyright © 2017 HireRussians. All rights reserved.
//

#import "UIViewController(HRLoad).h"

@implementation UIViewController (HRLoad)

+ (instancetype) hrViewController{
    NSString* name = NSStringFromClass([self class]);
    UIViewController* vc = [UIStoryboard storyboardWithName:name bundle:nil].instantiateInitialViewController;
    return vc;
}

+ (instancetype) hrViewControllerWithViewModel:(id)viewModel {
    UIViewController* vc = [self hrViewController];
    [vc setViewModel:viewModel];
    return vc;
}

- (void) setViewModel:(id) viewModel{
}


@end

@implementation UINavigationController(HRLoad)

- (void) setViewModel:(id) viewModel{
    [self.viewControllers.lastObject setViewModel:viewModel];
}

@end
