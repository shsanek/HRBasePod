//
//  HRLocalizationFunction.h
//  Vivid
//
//  Created by Alexander Shipin on 02/03/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRLocalizedStringController : NSObject

+ (instancetype) shared;

@property (nonatomic, strong, readonly) NSString* languages;
@property (nonatomic, strong, readonly) NSBundle* lastLocaleBundle;

- (void) update;

@end

NSString* HRFastLocalizedString(NSString* key,NSString* comment);
NSString* HRLocalizedString(NSString* key,NSString* comment);
