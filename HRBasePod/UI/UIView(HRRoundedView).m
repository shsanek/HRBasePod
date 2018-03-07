//
//  UIView(HRRoundedView).m
//  HR lib
//
//  Created by Shipin Alex on 24/11/15.
//  Copyright © 2015 HR. All rights reserved.
//

#import "UIView(HRRoundedView).h"

@implementation UIView(HRRoundedView)

- (void)setHrBorderColor:(UIColor *)hrBorderColor {
    self.layer.borderColor = hrBorderColor.CGColor;
}

- (UIColor *)hrBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setHrBorderWidth:(CGFloat)hrBorderWidth {
    self.layer.borderWidth = hrBorderWidth;
}

- (CGFloat)hrBorderWidth{
    return  self.layer.borderWidth;
}

- (void)setHrCornerRadius:(CGFloat)hrCornerRadius {
    self.layer.cornerRadius = hrCornerRadius;
}

- (CGFloat)hrCornerRadius {
    return  self.layer.cornerRadius;
}

@end
