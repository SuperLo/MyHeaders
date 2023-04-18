//
//  NSString+MyExtension.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (MyExtension)
#pragma mark - 实例方法 :

#pragma mark - ###### : string to controller
- (UIViewController *)stringToController;

#pragma mark - ###### : 通过控制器名字 推出控制器
- (void)pushed;

#pragma mark - ###### : string 转 image
- (UIImage *)image;

#pragma mark - ###### : string 转 URL
- (NSURL *)url;

#pragma mark - ###### : 整形 转 字符串
+(NSString *)longToString:(NSInteger)value; 

#pragma mark - ###### : 获取 汉字的首字母
- (NSString *)firstCharactor;

#pragma mark - ###### : 获取 拼音
-(NSString *)pinyin;

#pragma mark - ###### : 获取 MD5
- (NSString *)MD5String;

#pragma mark - ###### :  json string 转 dictionary
- (NSDictionary *)dictionary;

#pragma mark - ###### : ------ 日期 -------

#pragma mark - ###### : 秒数 转 日期
+ (NSDate *)dateWithSeconds:(NSInteger)seconds;
+ (NSString *)dateStringWithSeconds:(NSInteger)seconds Format:(NSString *)format;

#pragma mark - ###### : 本地时间戳
+(NSString *)localTime;

#pragma mark - ###### : 时间戳格式

/// 时间戳格式
/// - Parameter format: eg. yyyy-MM-dd HH:mm:SS
-(NSString *)format:(NSString *)format;

#pragma mark - ###### : 获取当前时间的字符串
+(NSString *)timeString;

#pragma mark - ###### : 当前时间的秒数
+(NSInteger)currentSeconds;

#pragma mark - ###### : 判断 日期 是否是今天
-(BOOL)isToday;

#pragma mark - ###### : 过去多久时间

/// eg. 刚刚  |  昨天  |  三天前
-(NSString *)timeAgo;

#pragma mark - ###### : 获取 N天前日期
+(NSString *)getNDayBefore:(NSInteger)n;

#pragma mark - ###### : 判断 日期 是否是n天内
- (BOOL)isTimeInDays:(NSInteger)num;

#pragma mark - // attribute 部分文字处理
-(NSMutableAttributedString *)rangeText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color;

#pragma mark - ###### : html
- (NSAttributedString *)htmlToAttrbuteString;
- (NSAttributedString *)htmlToAttrbuteStringWithSpace:(CGFloat)space;

#pragma mark - ###### : 获取 文字 宽度
- (CGFloat)widthWithSizeHeight:(CGFloat)height font:(UIFont *)font;

#pragma mark - ###### : 获取 文字 高度
- (CGFloat)heightWithSizeWidth:(CGFloat)width space:(CGFloat)space font:(UIFont *)font;

#pragma mark - ###### : 普通字符串 转 十六进制字符串
+ (NSString *)hexStringFromString:(NSString *)string;

#pragma mark - ###### : 整形 转 二进制 字符串
+ (NSString *)binaryStringFromInteger:(NSInteger)value;

#pragma mark - ###### : 设置上下标
-(NSAttributedString *)superscriptWithText:(NSString *)text Font:(UIFont *)font Up:(BOOL)isUp;
-(NSAttributedString *)superscriptWithRange:(NSRange)range Font:(UIFont *)font Up:(BOOL)isUp;

#pragma mark - ###### : plistNameToDictionary
-(NSDictionary *)plistNameToDictionary;

#pragma mark - ###### : 判断 string 是否是 手机号
- (BOOL)isMobile;

#pragma mark - ###### : 判断 string 是否 邮箱格式
- (BOOL)isEmail;

#pragma mark - ###### : 判断 string 是否为空
+ (BOOL) stringIsNull:(NSString *)str;

#pragma mark - ###### : 判断 string 是否为空
-(BOOL)isBlank;

#pragma mark - ###### : 判断 string 是否含有Emoji
-(BOOL)stringContainsEmoji;

#pragma mark - 静态方法 :
#pragma mark - //版本
+ (NSString *)appName;
+ (NSString *)appVersion;
+ (NSString *)buildVersion;
@end

NS_ASSUME_NONNULL_END
