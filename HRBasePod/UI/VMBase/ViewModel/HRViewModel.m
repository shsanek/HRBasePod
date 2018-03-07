//
//  HRViewModel.m
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRViewModel.h"

@implementation HRViewModel{
    id _hr_private_UpdateDelgate;
}

- (void)setUpdateDelegate:(id<HRViewModelUpdateDelegate>)updateDelegate {
    _hr_private_UpdateDelgate = updateDelegate;
}

- (id<HRViewModelUpdateDelegate>) updateDelegate{
    return _hr_private_UpdateDelgate;
}

@end
