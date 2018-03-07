//
//  HRRGBColor.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HR_RGB(r,g,b) [UIColor colorWithRed:((float)r)/255.0f green:((float)g)/255.0f blue:((float)b)/255.0f alpha:1.0f]
#define HR_RGBA(r,g,b,a) [UIColor colorWithRed:((float)r)/255.0f green:((float)g)/255.0f blue:((float)b)/255.0f alpha:((float)a)/255.0f]

UIColor* fHRColorWithHashString(NSString* hash);
