//
//  NSString+HRSupported.m
//  HR
//
//  Created by Alexander Shipin on 16/12/2017.
//  Copyright © 2017 Alexander Shipin. All rights reserved.
//

#import "NSString+HRSupported.h"

@implementation NSString (HRSupported)

- (NSString *)firstGroupSymbols {
    if (self.length == 0) {
        return @"";
    }
    NSString* up = [self uppercaseString];
    NSString* lower = [self lowercaseString];
    NSInteger index = 0;
    if ([up characterAtIndex:0] == [self characterAtIndex:0]) {
        for (index = 0 ; index < up.length; index++) {
            if ([up characterAtIndex:0] != [self characterAtIndex:0]) {
                break;
            }
        }
    } else if ([lower characterAtIndex:0] == [self characterAtIndex:0]) {
        for (index = 0 ; index < up.length; index++) {
            if ([up characterAtIndex:0] != [lower characterAtIndex:0]) {
                break;
            }
        }
    }
    if (index == self.length) {
        return @"";
    }
    if (index == 0) {
        return self;
    } else {
        return [self substringWithRange:NSMakeRange(0, index)];
    }
}

- (NSString*) downFirstGroupSymbols{
    NSString* firstGroupSymbols = [self firstGroupSymbols];
    if (firstGroupSymbols.length > 0) {
        return [NSString stringWithFormat:@"%@%@",[firstGroupSymbols lowercaseString],[self substringWithRange:NSMakeRange(firstGroupSymbols.length, self.length - firstGroupSymbols.length)]];
    }
    return self;
}

- (NSString*) upFirstGroupSymbols{
    NSString* firstGroupSymbols = [self firstGroupSymbols];
    if (firstGroupSymbols.length > 0) {
        return [NSString stringWithFormat:@"%@%@",[firstGroupSymbols uppercaseString],[self substringWithRange:NSMakeRange(firstGroupSymbols.length, self.length - firstGroupSymbols.length)]];
    }
    return self;
}

- (NSString*) downFirstSymbols{
    if (self.length < 1) {
        return self;
    }
    return [NSString stringWithFormat:@"%@%@",
            [[self substringWithRange:NSMakeRange(0, 1)] lowercaseString],
            [self substringWithRange:NSMakeRange(1, self.length - 1)]];
}
- (NSString*) upFirstSymbols{
    if (self.length < 1) {
        return self;
    }
    return [NSString stringWithFormat:@"%@%@",
            [[self substringWithRange:NSMakeRange(0, 1)] uppercaseString],
            [self substringWithRange:NSMakeRange(1, self.length - 1)]];
}

- (NSArray<NSString*>*) getSubstringBetweenFirstChar:(NSString*) firstChar
                                          secondChar:(NSString*) secondChar{
    NSMutableArray* list = [NSMutableArray new];
    NSInteger pool = 0;
    int startSymbol = 0;
    for (int i = 0; i < self.length; i++) {
        if (pool == 0 && [self characterAtIndex:i] == [firstChar characterAtIndex:0] ) {
            pool++;
            startSymbol++;
        } else if (pool > 0 && [self characterAtIndex:i] == [firstChar characterAtIndex:0]) {
            pool++;
        } else if (pool > 0 && [self characterAtIndex:i] == [secondChar characterAtIndex:0]) {
            pool--;
            if (pool == 0) {
                NSInteger length = i - startSymbol - 1;
                if (length > 0) {
                    [list addObject:[self substringWithRange:NSMakeRange(startSymbol + 1, length)]];
                } else {
                    [list addObject:@""];
                }
            }
        }
    }
    return list;
}

@end
