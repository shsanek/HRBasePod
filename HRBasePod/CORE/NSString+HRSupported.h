//
//  NSString+HRSupported.h
//  HR
//
//  Created by Alexander Shipin on 16/12/2017.
//  Copyright © 2017 Alexander Shipin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HRSupported)

- (NSString*) firstGroupSymbols;
- (NSString*) downFirstGroupSymbols;
- (NSString*) upFirstGroupSymbols;

- (NSString*) downFirstSymbols;
- (NSString*) upFirstSymbols;

- (NSArray<NSString*>*) getSubstringBetweenFirstChar:(NSString*) firstChar
                                          secondChar:(NSString*) secondChar;
@end
