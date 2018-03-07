//
//  UIView(HRConstraint).m
//  HR lib
//
//  Created by Shipin Alex on 29/10/15.
//  Copyright © 2015 HR. All rights reserved.
//

#import "UIView(HRConstraint).h"

@implementation UIView(HRConstraint)

- (NSArray<NSLayoutConstraint*>*) hrAddMarginConstraintSubview:(UIView*) view{
    return [self hrAddMarginConstraintSubview:view top:0 bottom:0 right:0 left:0];
}

- (NSArray<NSLayoutConstraint*>*) hrAddMarginConstraintSubview:(UIView*) view top:(CGFloat) top bottom:(CGFloat) bottom right:(CGFloat) right left:(CGFloat) left{
    NSArray* result = @[[NSLayoutConstraint constraintWithItem:self
                                                     attribute:(NSLayoutAttributeTop)
                                                     relatedBy:(NSLayoutRelationEqual)
                                                        toItem:view
                                                     attribute:(NSLayoutAttributeTop)
                                                    multiplier:1.
                                                      constant:top],
                        [NSLayoutConstraint constraintWithItem:self
                                                     attribute:(NSLayoutAttributeBottom)
                                                     relatedBy:(NSLayoutRelationEqual)
                                                        toItem:view
                                                     attribute:(NSLayoutAttributeBottom)
                                                    multiplier:1.
                                                      constant:bottom],
                        [NSLayoutConstraint constraintWithItem:self
                                                     attribute:(NSLayoutAttributeRight)
                                                     relatedBy:(NSLayoutRelationEqual)
                                                        toItem:view
                                                     attribute:(NSLayoutAttributeRight)
                                                    multiplier:1.
                                                      constant:right],
                        [NSLayoutConstraint constraintWithItem:self
                                                     attribute:(NSLayoutAttributeLeft)
                                                     relatedBy:(NSLayoutRelationEqual)
                                                        toItem:view
                                                     attribute:(NSLayoutAttributeLeft)
                                                    multiplier:1.
                                                      constant:left]];
    [self addConstraints:result];
    return result;
}

@end
