//
//  UIFont+MyExtension.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define MYFont_Regular(x) [UIFont myRegularSize:x]
#define MYFont_Semibold(x) [UIFont mySemiboldSize:x]
#define MYFont_Medium(x) [UIFont myMediumSize:x]
#define MYFont_Ultralight(x) [UIFont myUltralightSize:x]
#define MYFont_Thin(x) [UIFont myThinSize:x]
#define MYFont_Light(x) [UIFont myLightSize:x]


@interface UIFont (MyExtension)

+(UIFont *)myThinSize:(CGFloat)size;
+(UIFont *)myUltralightSize:(CGFloat)size;
+(UIFont *)myLightSize:(CGFloat)size;
+(UIFont *)myMediumSize:(CGFloat)size;
+(UIFont *)mySemiboldSize:(CGFloat)size;
+(UIFont *)myRegularSize:(CGFloat)size;


+(void)setDefaultFontName_Regular:(NSString *)fontName;
+(void)setDefaultFontName_Semibold:(NSString *)fontName;
+(void)setDefaultFontName_Medium:(NSString *)fontName;
+(void)setDefaultFontName_Light:(NSString *)fontName;
+(void)setDefaultFontName_Ultralight:(NSString *)fontName;
+(void)setDefaultFontName_Thin:(NSString *)fontName;
@end

NS_ASSUME_NONNULL_END
