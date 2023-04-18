//
//  NSString+MyUnicode.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import "NSString+MyUnicode.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static inline void SN_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@implementation NSString (MyUnicode)
- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (MyUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SN_swizzleSelector(class, @selector(description), @selector(SN_description));
        SN_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(SN_descriptionWithLocale:));
        SN_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(SN_descriptionWithLocale:indent:));
    });
}

/**
 *  我觉得
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)SN_description {
    return [[self SN_description] stringByReplaceUnicode];
}

- (NSString *)SN_descriptionWithLocale:(nullable id)locale {
    return [[self SN_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)SN_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self SN_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (MyUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SN_swizzleSelector(class, @selector(description), @selector(SN_description));
        SN_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(SN_descriptionWithLocale:));
        SN_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(SN_descriptionWithLocale:indent:));
    });
}

- (NSString *)SN_description {
    return [[self SN_description] stringByReplaceUnicode];
}

- (NSString *)SN_descriptionWithLocale:(nullable id)locale {
    return [[self SN_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)SN_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self SN_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (MyUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SN_swizzleSelector(class, @selector(description), @selector(SN_description));
        SN_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(SN_descriptionWithLocale:));
        SN_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(SN_descriptionWithLocale:indent:));
    });
}

- (NSString *)SN_description {
    return [[self SN_description] stringByReplaceUnicode];
}

- (NSString *)SN_descriptionWithLocale:(nullable id)locale {
    return [[self SN_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)SN_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self SN_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
