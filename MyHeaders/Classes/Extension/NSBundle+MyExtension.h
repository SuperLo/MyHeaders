//
//  NSBundle+MyExtension.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (MyExtension)
// 设置语言
+ (void)setLanguage:(NSString *)language;
@end

NS_ASSUME_NONNULL_END
