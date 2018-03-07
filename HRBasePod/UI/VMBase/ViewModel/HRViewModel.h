//
//  HRViewModel.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRCore.h"

@class HRViewModel;

@protocol HRViewModelUpdateDelegate <NSObject>

- (void) didUpdateDataInViewModel:(HRViewModel*) delegate;
- (void) viewModel:(HRViewModel*) viewModel showErrorMessage:(NSString*) message;

@end

@protocol HRViewModelProtocol<NSObject>

- (void)setUpdateDelegate:(id<HRViewModelUpdateDelegate>)updateDelegate;
- (id<HRViewModelUpdateDelegate>) updateDelegate;

@end

@interface HRViewModel : NSObject <HRViewModelProtocol>


@end
