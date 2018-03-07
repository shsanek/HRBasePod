//
//  HRViewController.m
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRViewController.h"

@interface HRViewController ()

@end

@implementation HRViewController

- (void) setNeedUpdate{
    _isNeedUpdate = YES;
}

- (void) updateIfNeed {
    if (self.isViewLoaded && self.viewModel && self.isNeedUpdate) {
        _isNeedUpdate = NO;
        [self allUpdate];
    }
}

- (void)allUpdate {
    _isNeedUpdate = NO;
}

- (HRViewModel*) viewModel{
    return nil;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self updateIfNeed];
}

- (void)setViewModel:(HRViewModel *)viewModel {
    viewModel.updateDelegate = self;
    [self setNeedUpdate];
    [self updateIfNeed];
    [self loadViewIfNeeded];
}

- (IBAction) backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) dismissAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL) searchKeyboardInView:(UIView*) view{
    if ([view isFirstResponder]) {
        [view resignFirstResponder];
        return YES;;
    }
    for (UIView* v in view.subviews) {
        if ([self searchKeyboardInView:v]){
            return YES;
        }
    }
    return NO;
}

- (IBAction) dismissKeyboard:(id)sender{
    [self searchKeyboardInView:self.view];
}

#pragma mark - HRViewModelUpdateDelegate <NSObject>
- (void) didUpdateDataInViewModel:(HRViewModel*) delegate{
    [self setNeedUpdate];
    [self updateIfNeed];
}

- (void) viewModel:(HRViewModel*) viewModel showErrorMessage:(NSString*) message{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:(UIAlertActionStyleCancel)
                                            handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
