//
//  HRLocalizationFunction.m
//  Vivid
//
//  Created by Alexander Shipin on 02/03/2018.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "HRLocalizationFunction.h"

@interface HRLocalizedStringController ()


@property (nonatomic, strong, readwrite) NSString* languages;
@property (nonatomic, strong, readwrite) NSBundle* lastLocaleBundle;


@end

@implementation HRLocalizedStringController

+ (instancetype) shared{
    static HRLocalizedStringController* result;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [HRLocalizedStringController new];
    });
    return result;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self update];
    }
    return self;
}


- (void) update{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString       *locale   = [[defaults objectForKey: @"AppleLanguages"] firstObject];
    self.languages = locale;
    self.lastLocaleBundle = nil;
    if (locale != nil)
    {
        NSString *path =
        [[NSBundle mainBundle] pathForResource: locale
                                        ofType: @"lproj"];
        
        if (path != nil)
        {
            NSBundle *localeBundle = [NSBundle bundleWithPath: path];
            
            [localeBundle load];
            
            self.lastLocaleBundle = localeBundle;
        }
    }
}

@end

NSString* HRFastLocalizedString(NSString* key,NSString* comment){
    NSString *string = [[NSBundle mainBundle] localizedStringForKey: (key)
                                                              value: @""
                                                              table: nil];
    NSString* newString = [[HRLocalizedStringController shared].lastLocaleBundle localizedStringForKey: (key)
                                                                                                 value: @""
                                                                                                 table: nil];
    return newString?newString:string;
}

NSString* HRLocalizedString(NSString* key,NSString* comment){
    NSString *string = [[NSBundle mainBundle] localizedStringForKey: (key)
                                                              value: @""
                                                              table: nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString       *locale   = [[defaults objectForKey: @"AppleLanguages"] firstObject];
    
    if (locale != nil)
    {
        NSString *path =
        [[NSBundle mainBundle] pathForResource: locale
                                        ofType: @"lproj"];
        
        if (path != nil)
        {
            NSBundle *localeBundle = [NSBundle bundleWithPath: path];
            
            [localeBundle load];
                        
            string = [localeBundle localizedStringForKey: (key)
                                                   value: @""
                                                   table: nil];
        }
    }
    
    return string;
}
