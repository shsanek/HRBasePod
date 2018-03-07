//
//  HRRGBColor.c
//  Vivid
//
//  Created by Alexander Shipin on 18/12/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRRGBColor.h"

int f_private_HR_numberWith16Text(NSString* text) {
    int result = 0;
    for (int i = 0; i < text.length; i++) {
        result *= 16;
        char c =  [text characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            result += (c - '0');
        } else {
            result += (c - 'A' + 10);
        }
    }
    return result;
}

UIColor* f_private_HR_rgbWithString(NSString* text) {
    text = [text uppercaseString];
    if (text.length == 7) {
        NSString* r = [text substringWithRange:NSMakeRange(1, 2)];
        NSString* g = [text substringWithRange:NSMakeRange(3, 2)];
        NSString* b = [text substringWithRange:NSMakeRange(5, 2)];
        float rFloat = f_private_HR_numberWith16Text(r);
        float gFloat = f_private_HR_numberWith16Text(g);
        float bFloat = f_private_HR_numberWith16Text(b);
        return HR_RGB(rFloat, gFloat, bFloat);
    }
    return nil;
}

UIColor* fHRColorWithHashString(NSString* hash){
    return f_private_HR_rgbWithString(hash);
}
