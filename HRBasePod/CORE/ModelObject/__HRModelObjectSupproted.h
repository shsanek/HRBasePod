//
//  __HRModelObjectSupproted.h
//  Vivid
//
//  Created by Alexander Shipin on 16/12/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HRProperty;

@interface __HRModelObjectSupproted : NSObject

@property (nonatomic, strong, readonly) NSArray<HRProperty*>* loadPropertyes;
@property (nonatomic, strong, readonly) NSArray<HRProperty*>* savePropertyes;
@property (nonatomic, strong, readonly) NSArray<HRProperty*>* descriptionPropertyes;
@property (nonatomic, strong, readonly) NSArray<HRProperty*>* requiredPropertyes;
@property (nonatomic, strong, readonly) NSDictionary<NSString*,NSString*>* keys;

- (instancetype) initWithClass:(Class) currentClass;

@end
