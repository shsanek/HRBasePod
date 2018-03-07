//
//  HRIdentifierGenerator.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRIdentifierGenerator : NSObject

@property (nonatomic, strong) NSString* prefix;

- (instancetype) initWithPrefix:(NSString*) prefix;

- (void) registerIdentifier:(NSString*) identifier;
- (NSString*) registerIdentifierForClass:(Class) object;
- (NSString*) identifierForObject:(NSObject*) object;

@end
