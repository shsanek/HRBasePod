//
//  UIView(HRConstraint).h
//  HR lib
//
//  Created by Shipin Alex on 29/10/15.
//  Copyright © 2015 HR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(HRConstraint)

- (NSArray<NSLayoutConstraint*>*) hrAddMarginConstraintSubview:(UIView*) view;
- (NSArray<NSLayoutConstraint*>*) hrAddMarginConstraintSubview:(UIView*) view
                                                           top:(CGFloat) top
                                                        bottom:(CGFloat) bottom
                                                         right:(CGFloat) right
                                                          left:(CGFloat) left;

@end
