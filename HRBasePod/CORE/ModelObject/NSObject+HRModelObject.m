//
//  NSObject+HRModelObject.m
//  HR
//
//  Created by Alexander Shipin on 15/12/2017.
//  
//

#import "NSObject+HRModelObject.h"
#import "NSObject+HRGetSubclass.h"
#import "__HRModelObjectSupproted.h"
#import <objc/runtime.h>
@implementation NSObject (HRModelObject)

#pragma mark - Setters
#define HR_PRIVATE_METHODS(NAME,TYPE) \
- (void) hr_set##NAME :(TYPE) obj forProperty:(HRProperty*) property {\
    IMP implementation = [self methodForSelector:property.setSelector];\
    void (*set)(id obj,SEL sel,TYPE value) = (void*)implementation;\
    set(self,property.setSelector,obj);\
}\
\
- (TYPE) hr_get##NAME##ForProperty:(HRProperty*) property {\
    IMP implementation = [self methodForSelector:property.getSelector];\
    TYPE (*get)(id obj,SEL sel) = (void*)implementation;\
    return get(self,property.setSelector);\
}

HR_PRIVATE_METHODS(Object,id);
HR_PRIVATE_METHODS(Bool,BOOL);
HR_PRIVATE_METHODS(Int,int);
HR_PRIVATE_METHODS(Int32,int32_t);
HR_PRIVATE_METHODS(Int64,int64_t);
HR_PRIVATE_METHODS(Float,float);
HR_PRIVATE_METHODS(Double,double);
HR_PRIVATE_METHODS(UInteger,NSUInteger);
HR_PRIVATE_METHODS(Integer,NSInteger);

- (void) didLoadModel{
    
}

- (void) __private_didLoadModel{
    if ([[self class] primaryKey] && [[self class] conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
        Class classForObject = NSClassFromString(@"___HR__TMPObject");

        {
            SEL sel = @selector(isEqual:);
            IMP c  = class_getMethodImplementation([self class],sel);
            IMP a  = class_getMethodImplementation(classForObject,sel);
            IMP b  = class_getMethodImplementation([NSObject class],sel);
            if (c != a && c == b) {
                struct objc_method *method = (struct objc_method*) class_getInstanceMethod([self class], sel);
                IMP imp  = class_getMethodImplementation(classForObject,sel);
                method_setImplementation(method,imp);
            }
        }
        {
            SEL sel = @selector(primaryProperty);
            IMP c  = class_getMethodImplementation([self class],sel);
            IMP a  = class_getMethodImplementation(classForObject,sel);
            IMP b  = class_getMethodImplementation([NSObject class],sel);
            if (c != a && c == b) {
                struct objc_method *method = (struct objc_method*) class_getInstanceMethod([self class], sel);
                IMP imp  = class_getMethodImplementation(classForObject,sel);
                method_setImplementation(method,imp);
            }
        }
        {
            SEL sel = @selector(hash);
            IMP c  = class_getMethodImplementation([self class],sel);
            IMP a  = class_getMethodImplementation(classForObject,sel);
            IMP b  = class_getMethodImplementation([NSObject class],sel);
            if (c != a && c == b) {
                struct objc_method *method = (struct objc_method*) class_getInstanceMethod([self class], sel);
                IMP imp  = class_getMethodImplementation(classForObject,sel);
                method_setImplementation(method,imp);
            }
        }
    }
    [self didLoadModel];
}


#pragma mark - NSCoder
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        __HRModelObjectSupproted *supported = [[__HRModelObjectSupproted alloc] initWithClass:[self class]];
        for (HRProperty* property in [supported loadPropertyes]) {
            Class currentClass = NSClassFromString(property.type);
            NSString* key = supported.keys[property.name];
            key = key?key:property.name;
            if (currentClass) {
                if ([currentClass conformsToProtocol:@protocol(NSCoding)]) {
                    id obj = [aDecoder decodeObjectForKey:key];
                    NSAssert(!(!obj && [supported.requiredPropertyes containsObject:property]), @"It is required Propertyes");
                    [self hr_setObject:obj forProperty:property];
                } else {
                    NSAssert(NO, @"Class \"%@\" not support NSCoding(add ignored protocol for property)",NSStringFromClass(currentClass));
                }
            } else {
                if ([property.type isEqualToString:@"BOOL"]) {
                    BOOL obj = [aDecoder decodeBoolForKey:key];
                    [self hr_setBool:obj forProperty:property];
                } else if ([property.type isEqualToString:@"float"]) {
                    float obj = [aDecoder decodeFloatForKey:key];
                    [self hr_setFloat:obj forProperty:property];
                } else if ([property.type isEqualToString:@"double"]) {
                    double obj = [aDecoder decodeDoubleForKey:key];
                    [self hr_setDouble:obj forProperty:property];
                } else if ([property.type isEqualToString:@"int"]) {
                    int obj = [aDecoder decodeIntForKey:key];
                    [self hr_setInt:obj forProperty:property];
                } else if ([property.type isEqualToString:@"integer"]) {
                    NSInteger obj = [aDecoder decodeIntegerForKey:key];
                    [self hr_setInteger:obj forProperty:property];
                } else if ([property.type isEqualToString:@"uinteger"]) {
                    NSUInteger obj = [aDecoder decodeIntegerForKey:key];
                    [self hr_setUInteger:obj forProperty:property];
                } else {
                    NSAssert(NO, @"Class \"%@\" not support NSCoding(add property in ignored list)",NSStringFromClass(currentClass));
                }
            }
        }
        [self __private_didLoadModel];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    __HRModelObjectSupproted *supported = [[__HRModelObjectSupproted alloc] initWithClass:[self class]];
    for (HRProperty* property in [supported savePropertyes]) {
        Class currentClass = NSClassFromString(property.type);
        NSString* key = supported.keys[property.name];
        key = key?key:property.name;
        if (currentClass) {
            if ([currentClass conformsToProtocol:@protocol(NSCoding)]) {
                id obj = [self hr_getObjectForProperty:property];
                NSAssert(!(!obj && [supported.requiredPropertyes containsObject:property]), @"It is required Propertyes");
                [aCoder encodeObject:obj forKey:key];
            } else {
                NSAssert(NO, @"Class \"%@\" not support NSCoding(add ignored protocol for property)",NSStringFromClass(currentClass));
            }
        } else {
            if ([property.type isEqualToString:@"BOOL"]) {
                BOOL obj = [self hr_getBoolForProperty:property];
                [aCoder encodeBool:obj forKey:key];
            } else if ([property.type isEqualToString:@"float"]) {
                float obj = [self hr_getFloatForProperty:property];
                [aCoder encodeFloat:obj forKey:key];
            } else if ([property.type isEqualToString:@"double"]) {
                double obj = [self hr_getDoubleForProperty:property];
                [aCoder encodeDouble:obj forKey:key];
            } else if ([property.type isEqualToString:@"int"]) {
                int obj = [self hr_getIntForProperty:property];
                [aCoder encodeInt:obj forKey:key];
            } else if ([property.type isEqualToString:@"integer"]) {
                NSInteger obj = [self hr_getIntegerForProperty:property];
                [aCoder encodeInteger:obj forKey:key];
            } else if ([property.type isEqualToString:@"uinteger"]) {
                NSUInteger obj = [self hr_getUIntegerForProperty:property];
                [aCoder encodeInteger:obj forKey:key];
            } else {
                NSAssert(NO, @"Class \"%@\" not support NSCoding(add property in ignored list)",NSStringFromClass(currentClass));
            }
        }
    }
}

#pragma mark - HRModelObjectProtocol
+ (NSArray<NSString*>*) loadIgnorePropertyNames{
    return @[];
}

+ (NSArray<NSString*>*) saveIgnorePropertyNames{
    return @[];
}

+ (NSArray<NSString*>*) descriptionIgnorePropertyNames{
    return @[];
}

+ (NSArray<NSString*>*) requiredPropertyNames{
    return @[];
}

+ (NSString*) primaryKey{
    return nil;
}

+ (NSDictionary<NSString*,NSString*>*) dictionaryKeyForObject{
    return @{};
}


#pragma mark - Private
- (NSString*) hr_p_ModelObjectDescriptionLevel:(int) level{
    NSMutableString* result = [NSMutableString new];
    [result appendFormat:@"(%p)<",self];
    BOOL added = NO;
    __HRModelObjectSupproted *supported = [[__HRModelObjectSupproted alloc] initWithClass:[self class]];
    for (HRProperty* property in [supported descriptionPropertyes]) {
        if (added) {
            [result appendString:@","];
        }
        [result appendString:@"\n"];
        for (int i = 0; i < level; i++ ) {
            [result appendString:@"  "];
        }
        [result appendFormat:@"<%@> : ",property.name];
        
        added = YES;
        Class currentClass = NSClassFromString(property.type);
        NSString* key = supported.keys[property.name];
        key = key?key:property.name;
        if (currentClass) {
            id obj = [self hr_getObjectForProperty:property];
            if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
                [result appendFormat:@"%@",[obj hr_p_ModelObjectDescriptionLevel:level + 1]];
            }  else {
                [result appendFormat:@"%@",obj];
            }
        } else {
            if ([property.type isEqualToString:@"BOOL"]) {
                BOOL obj = [self hr_getBoolForProperty:property];
                obj?[result appendString:@"YES"]:[result appendString:@"NO"];
            } else if ([property.type isEqualToString:@"float"]) {
                float obj = [self hr_getFloatForProperty:property];
                [result appendFormat:@"%f",obj];
            } else if ([property.type isEqualToString:@"double"]) {
                double obj = [self hr_getDoubleForProperty:property];
                [result appendFormat:@"%f",obj];
            } else if ([property.type isEqualToString:@"int"]) {
                int obj = [self hr_getIntForProperty:property];
                [result appendFormat:@"%d",obj];
            } else if ([property.type isEqualToString:@"integer"]) {
                NSInteger obj = [self hr_getIntegerForProperty:property];
                [result appendFormat:@"%ld",obj];
            } else if ([property.type isEqualToString:@"uinteger"]) {
                NSUInteger obj = [self hr_getUIntegerForProperty:property];
                [result appendFormat:@"%lu",obj];
            }
        }
    }
    [result appendString:@"\n"];
    for (int i = 0; i < level - 1; i++ ) {
        [result appendString:@"  "];
    }
    [result appendString:@">"];
    return result;
}


+ (instancetype) createWithObject:(id) object withParameters:(NSArray<NSString*>*) parameters{
    return [[self alloc] initWithObject:object withParameters:parameters];;
}


- (instancetype) initWithObject:(id) object withParameters:(NSArray<NSString*>*) parameters{
    if (parameters != nil) {
        return [self initFromDictionary:object];
    }
    self = [self init];
    if (self) {
        __HRModelObjectSupproted *supported = [[__HRModelObjectSupproted alloc] initWithClass:[self class]];
        for (HRProperty* property in [supported loadPropertyes]) {
            Class currentClass = NSClassFromString(property.type);
            NSString* key = supported.keys[property.name];
            key = key?key:property.name;
            if (currentClass) {
                id obj = object[key];
                NSAssert(!(!obj && [supported.requiredPropertyes containsObject:property]), @"It is required Propertyes");
                if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
                    [self hr_setObject:[currentClass createWithObject:obj withParameters:property.parameters]
                           forProperty:property];
                } else {
                    IMP a = [NSObject instanceMethodForSelector:@selector(initWithDictionary:)];
                    IMP b = [currentClass instanceMethodForSelector:@selector(initWithDictionary:)];
                    if (a != b) {
                        [self hr_setObject:[[currentClass alloc] initWithDictionary:obj]
                               forProperty:property];
                    } else {
                        [self hr_setObject:obj
                               forProperty:property];
                    }
                }
            } else {
                if ([property.type isEqualToString:@"BOOL"]) {
                    BOOL obj = [object[key] boolValue];
                    [self hr_setBool:obj forProperty:property];
                } else if ([property.type isEqualToString:@"float"]) {
                    float obj = [object[key] floatValue];
                    [self hr_setFloat:obj forProperty:property];
                } else if ([property.type isEqualToString:@"double"]) {
                    double obj = [object[key] doubleValue];
                    [self hr_setDouble:obj forProperty:property];
                } else if ([property.type isEqualToString:@"int"]) {
                    int obj = [object[key] intValue];
                    [self hr_setInt:obj forProperty:property];
                } else if ([property.type isEqualToString:@"integer"]) {
                    NSInteger obj = [object[key] integerValue];
                    [self hr_setInteger:obj forProperty:property];
                } else if ([property.type isEqualToString:@"uinteger"]) {
                    NSUInteger obj = [object[key] integerValue];
                    [self hr_setUInteger:obj forProperty:property];
                } else {
                    NSAssert(NO, @"Class \"%@\" not support NSCoding(add property in ignored list)",NSStringFromClass(currentClass));
                }
            }
        }
        [self __private_didLoadModel];
    }
    return self;
}

- (id) containerFromModelObject{
    NSMutableDictionary* result = [NSMutableDictionary new];
    __HRModelObjectSupproted *supported = [[__HRModelObjectSupproted alloc] initWithClass:[self class]];
    for (HRProperty* property in [supported savePropertyes]) {
        Class currentClass = NSClassFromString(property.type);
        NSString* key = supported.keys[property.name];
        key = key?key:property.name;
        if (currentClass) {
            id obj = [self hr_getObjectForProperty:property];
            NSAssert(!(!obj && [supported.requiredPropertyes containsObject:property]), @"It is required Propertyes");
            if (obj) {
                if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
                    result[key] = [obj containerFromModelObject];
                } else {
                    IMP a = [currentClass instanceMethodForSelector:@selector(containerFromModelObject)];
                    IMP b = [currentClass instanceMethodForSelector:@selector(containerFromModelObject)];
                    if (a != b) {
                        result[key] = [obj containerFromModelObject];
                    } else {
                        result[key] = obj;
                    }
                }
            }
        } else {
            if ([property.type isEqualToString:@"BOOL"]) {
                BOOL obj = [self hr_getBoolForProperty:property];
                result[key] = @(obj);
            } else if ([property.type isEqualToString:@"float"]) {
                float obj = [self hr_getFloatForProperty:property];
                result[key] = @(obj);
            } else if ([property.type isEqualToString:@"double"]) {
                double obj = [self hr_getDoubleForProperty:property];
                result[key] = @(obj);
            } else if ([property.type isEqualToString:@"int"]) {
                int obj = [self hr_getIntForProperty:property];
                result[key] = @(obj);
            } else if ([property.type isEqualToString:@"integer"]) {
                NSInteger obj = [self hr_getIntegerForProperty:property];
                result[key] = @(obj);
            } else if ([property.type isEqualToString:@"uinteger"]) {
                NSUInteger obj = [self hr_getUIntegerForProperty:property];
                result[key] = @(obj);
            } else {
                NSAssert(NO, @"Class \"%@\" not support NSCoding(add property in ignored list)",NSStringFromClass(currentClass));
            }
        }
    }
    return result;
}

- (NSString *)description {
    Class currentClass = [self class];
    if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
        return [self hr_p_ModelObjectDescriptionLevel:0];
    }
    return [NSString stringWithFormat:@"<%@ : %p>",NSStringFromClass(currentClass),self];
}

#pragma mark - Model
- (id) initFromDictionary:(NSDictionary*) dictionary{
    return [self initWithObject:dictionary withParameters:nil];
}

+ (NSArray*) modelObjectListFromArray:(NSArray*) array{
    NSMutableArray* list = [NSMutableArray new];
    for (id obj in array) {
        [list addObject:[[self alloc] initFromDictionary:obj]];
    }
    return [list copy];
}

- (NSString*) modelObjectDescription{
    return [self hr_p_ModelObjectDescriptionLevel:0];
}


- (HRProperty*)primaryProperty {
    return nil;
}



+ (id) modelObjectFromDictionary:(NSDictionary*) dictionary{
    return [[self alloc] initFromDictionary:dictionary];
}

@end


@interface ___HR__TMPObject : NSObject

@end

@implementation ___HR__TMPObject

- (HRProperty*)primaryProperty {
    NSString* primaryKey = [[self class] primaryKey];
    if (!primaryKey) {
        return nil;
    }
    Class currentClass = [self class];
    NSArray<HRProperty*>* hrAllPropertys = [currentClass hrAllPropertys];
    for (HRProperty* prop in hrAllPropertys) {
        if ([primaryKey isEqualToString:prop.name]) {
            return prop;
        }
    }
    return nil;
}


- (NSUInteger)hash {
    HRProperty* property = [self primaryProperty];
    if (!property){
        return (NSUInteger)self;
    }
    Class currentClass = NSClassFromString(property.type);
    if (currentClass) {
        return [[self hr_getObjectForProperty:property] hash];
    } else {
        if ([property.type isEqualToString:@"BOOL"]) {
            return (NSUInteger)[self hr_getBoolForProperty:property];
        } else if ([property.type isEqualToString:@"float"]) {
            return (NSUInteger) [self hr_getFloatForProperty:property];
        } else if ([property.type isEqualToString:@"double"]) {
            return (NSUInteger) [self hr_getDoubleForProperty:property];
        } else if ([property.type isEqualToString:@"int"]) {
            return (NSUInteger) [self hr_getIntForProperty:property];
        } else if ([property.type isEqualToString:@"integer"]) {
            return (NSUInteger) [self hr_getIntegerForProperty:property];
        } else if ([property.type isEqualToString:@"uinteger"]) {
            return (NSUInteger) [self hr_getUIntegerForProperty:property];
        } else {
            NSAssert(NO, @"Class \"%@\" not support NSCoding(add property in ignored list)",NSStringFromClass(currentClass));
        }
    }
    return (NSUInteger)self;
}

- (BOOL)isEqual:(id)object {
    if (self == object){
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    HRProperty* property = [self primaryProperty];
    if (!property) {
        return self == object;
    }
    
    Class currentClass = NSClassFromString(property.type);
    if (currentClass) {
        return [[self hr_getObjectForProperty:property] isEqual:[object hr_getObjectForProperty:property]];
    } else {
        if ([property.type isEqualToString:@"BOOL"]) {
            return [self hr_getBoolForProperty:property] == [object hr_getBoolForProperty:property];
        } else if ([property.type isEqualToString:@"float"]) {
            return [self hr_getFloatForProperty:property] == [object hr_getFloatForProperty:property];
        } else if ([property.type isEqualToString:@"double"]) {
            return  [self hr_getDoubleForProperty:property] == [object hr_getDoubleForProperty:property];
        } else if ([property.type isEqualToString:@"int"]) {
            return [self hr_getIntForProperty:property] == [object hr_getIntForProperty:property];
        } else if ([property.type isEqualToString:@"integer"]) {
            return [self hr_getIntegerForProperty:property] == [object hr_getIntegerForProperty:property];
        } else if ([property.type isEqualToString:@"uinteger"]) {
            return [self hr_getUIntegerForProperty:property] == [object hr_getUIntegerForProperty:property];
        } else {
            NSAssert(NO, @"Class \"%@\" not support NSCoding(add property in ignored list)",NSStringFromClass(currentClass));
        }
    }
    return NO;
}

@end

@interface  NSArray(HRModelObject)<HRModelObjectProtocol>

@end

@implementation NSArray(HRModelObject)

- (NSString*) hr_p_ModelObjectDescriptionLevel:(int) level{
    NSMutableString* result = [NSMutableString new];
    [result appendString:@"[\n"];
    level++;
    BOOL added = NO;
    for (id obj in self) {
        if (added) {
            [result appendString:@",\n"];
        }
        for (int i = 0; i < level; i++ ) {
            [result appendString:@" "];
        }
        added = YES;
        Class currentClass = [obj class];
        if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            [result appendString:[obj hr_p_ModelObjectDescriptionLevel:level + 1]];
        } else {
            [result appendString:[obj description]];
        }
    }
    [result appendString:@"\n"];
    for (int i = 0; i < level - 1; i++ ) {
        [result appendString:@" "];
    }
    [result appendString:@"]"];
    return result;
}



- (NSString *)description {
    return [super description];
}


+ (instancetype) createWithObject:(id) object withParameters:(NSArray<NSString*>*) parameters{
    NSAssert([object isKindOfClass:[NSArray class]],@"incorrect class");
    NSMutableArray* list = [NSMutableArray new];
    Class currentClass = nil;
    for (NSString* sting in parameters) {
        Class class  = NSClassFromString(sting);
        if (class && [class conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            if (currentClass)  {
                NSAssert(NO, @"Mutaple model array protocol in parameters");
            }
            currentClass = class;
        }
    }
    for (id conObj in object) {
        if (currentClass) {
            [list addObject:[currentClass createWithObject:conObj withParameters:@[]]];
        } else {
            [list addObject:conObj];
        }
    }
    return [[self alloc] initWithArray:list];
}

- (instancetype) initWithObject:(id) object withParameters:(NSArray<NSString*>*) parameters{
    self = [self init];
    NSAssert(NO, @"Use modelObjectListFromArray:");
    return nil;;
}

- (id) containerFromModelObject{
    NSMutableArray* list = [NSMutableArray new];
    
    for (id conObj in self) {
        Class currentClass = [conObj class];
        if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            [list addObject:[conObj containerFromModelObject]];
        } else {
            IMP a = [currentClass instanceMethodForSelector:@selector(containerFromModelObject)];
            IMP b = [currentClass instanceMethodForSelector:@selector(containerFromModelObject)];
            if (a != b) {
                [list addObject:[conObj containerFromModelObject]];
            } else {
                [list addObject:conObj];
            }
        }
    }
    return list;
}

@end

@interface  NSDictionary(HRModelObject)<HRModelObjectProtocol>
@end

@implementation NSDictionary(HRModelObject)

- (NSString*) hr_p_ModelObjectDescriptionLevel:(int) level{
    NSMutableString* result = [NSMutableString new];
    [result appendString:@"{\n"];
    level ++;
    BOOL added = NO;
    for (id key in self.allKeys) {
        id obj = self[key];
        if (added) {
            [result appendString:@",\n"];
        }
        for (int i = 0; i < level; i++ ) {
            [result appendString:@" "];
        }
        added = YES;
        
        Class keyClass = [key class];
        if ([keyClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            [result appendString:[key hr_p_ModelObjectDescriptionLevel:level + 1]];
        } else {
            [result appendString:[key description]];
        }
        
        [result appendFormat:@" : "];
        
        Class currentClass = [obj class];
        if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            [result appendString:[obj hr_p_ModelObjectDescriptionLevel:level + 1]];
        } else {
            [result appendString:[obj description]];
        }
    }
    [result appendString:@"\n"];
    for (int i = 0; i < level - 1; i++ ) {
        [result appendString:@" "];
    }
    [result appendString:@"}"];
    return result;
}

+ (instancetype) createWithObject:(id) object withParameters:(NSArray<NSString*>*) parameters{
    NSAssert([object isKindOfClass:[NSDictionary class]],@"incorrect class");
    NSMutableDictionary* list = [NSMutableDictionary new];
    Class currentClass = nil;
    Class keyCurrentClass = nil;
    for (NSString* sting in parameters) {
        Class class  = NSClassFromString(sting);
        
        if (class && [class conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            if (keyCurrentClass)  {
                NSAssert(NO, @"Mutaple model array protocol in parameters");
            }
            if (currentClass)  {
                keyCurrentClass = class;
            } else {
                currentClass = class;
            }
        }
    }
    for (id keyObj in [object allKeys]) {
        id objKey = keyObj;
        id obj = object[keyObj];
        if (keyCurrentClass) {
            objKey = [keyCurrentClass createWithObject:objKey withParameters:@[]];
        }
        if (currentClass) {
            obj = [keyCurrentClass createWithObject:obj withParameters:@[]];
        }
        list[keyObj] = obj;
    }
    return [[self alloc] initWithDictionary:list];
}

- (instancetype) initWithObject:(id) object withParameters:(NSArray<NSString*>*) parameters{
    self = [self init];
    NSAssert(NO, @"Use modelObjectListFromArray:");
    return nil;;
}

- (id) containerFromModelObject{
    NSMutableDictionary* list = [NSMutableDictionary new];
    for (id key in [self allKeys]) {
        id conObj = self[key];
        id keyObj = key;
        Class keyCurrentClass = [key class];
        Class currentClass = [conObj class];
        if ([currentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            conObj =  [conObj containerFromModelObject];
        } else {
            IMP a = [currentClass instanceMethodForSelector:@selector(containerFromModelObject)];
            IMP b = [currentClass instanceMethodForSelector:@selector(containerFromModelObject)];
            if (a != b) {
                conObj =  [conObj containerFromModelObject];
            }
        }
        
        if ([keyCurrentClass conformsToProtocol:@protocol(HRModelObjectProtocol)]) {
            keyObj =  [conObj containerFromModelObject];
        } else {
            IMP a = [keyCurrentClass instanceMethodForSelector:@selector(containerFromModelObject)];
            IMP b = [keyCurrentClass instanceMethodForSelector:@selector(containerFromModelObject)];
            if (a != b) {
                keyObj =  [keyObj containerFromModelObject];
            }
        }
        list[keyObj] = conObj;
    }
    return list;
}

@end






