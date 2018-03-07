//
//  NSObject+HRModelObject.h
//  HR
//
//  Created by Alexander Shipin on 15/12/2017.
//
//

#import <Foundation/Foundation.h>

#define HR_MODEL_ARRAY_PROTOCOL(CLASS_MODEL)  @protocol CLASS_MODEL @end

@protocol LoadIgnore
@end

@protocol SaveIgnore
@end

@protocol DescriptionIgnore
@end

@protocol Required
@end



@protocol HRModelObjectProtocol<NSCoding>

@optional

- (void)encodeWithCoder:(NSCoder*)aCoder;
- (instancetype)initWithCoder:(NSCoder*)aDecoder;

+ (NSArray*) modelObjectListFromArray:(NSArray*) array;
+ (id) modelObjectFromDictionary:(NSDictionary*) dictionary;
- (NSString*) modelObjectDescription;
- (id) containerFromModelObject;
- (id) initFromDictionary:(NSDictionary*) dictionary;
- (void) didLoadModel;

+ (NSString*) primaryKey;
+ (NSArray<NSString*>*) loadIgnorePropertyNames;
+ (NSArray<NSString*>*) saveIgnorePropertyNames;
+ (NSArray<NSString*>*) descriptionIgnorePropertyNames;
+ (NSArray<NSString*>*) requiredPropertyNames;
+ (NSDictionary<NSString*,NSString*>*) dictionaryKeyForObject;

@end


@interface NSObject (HRModelObject)

- (void)encodeWithCoder:(NSCoder*)aCoder;
- (instancetype)initWithCoder:(NSCoder*)aDecoder;

@end
