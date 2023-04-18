//
//  NSString+MyExtension.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/17.
//

#import "NSString+MyExtension.h"
#import "UIViewController+MyExtension.h"

#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CoreText/CTStringAttributes.h>

@implementation NSString (MyExtension)


#pragma mark - 实例方法 :

#pragma mark - ###### : string to controller
- (UIViewController *)stringToController{
    UIViewController *vc=[[NSClassFromString(self) alloc] init];
    return vc;
}

#pragma mark - ###### : 通过控制器名字 推出控制器
-(void)pushed{
    [self.stringToController pushed];
}

#pragma mark - ###### : string 转 image
- (UIImage *)image{
    NSString *name = self;
    UIImage *image = nil;
    if (name&&name.length) {
        image= [UIImage imageNamed:name];
        NSString *tag=@"png";
        if (!image) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.%@",name,tag]];
        }
        if (!image) {
            NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:tag];
            image = [UIImage imageWithContentsOfFile:path];
        }
    }
    return image;
}

#pragma mark - ###### : string 转 URL
-(NSURL *)url{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
};

#pragma mark - ###### : 整形转字符串
+(NSString *)longToString:(NSInteger)value{
    NSString *string=@"";
    string=[NSString stringWithFormat:@"%ld",value];
    return string;
}
#pragma mark - ###### : 获取 汉字的首字母
- (NSString *)firstCharactor{
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *pinYin = [str capitalizedString];
    
    NSString *firatCharactors = [NSMutableString string];
    for (int i = 0; i < pinYin.length; i++) {
        if ([pinYin characterAtIndex:i] >= 'A' && [pinYin characterAtIndex:i] <= 'Z') {
            firatCharactors = [firatCharactors stringByAppendingString:[NSString stringWithFormat:@"%C",[pinYin characterAtIndex:i]]];
        }
    }
    if (firatCharactors.length>1) {
        firatCharactors=[firatCharactors substringToIndex:1];
    }else if(firatCharactors.length<1){
        firatCharactors=@"#";
    }
    return firatCharactors;
}
#pragma mark - ###### : 获取 拼音
-(NSString *)pinyin{
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *pinYin = [str capitalizedString];
    return pinYin;
}
#pragma mark - ###### : 获取 MD5
- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
#pragma mark - ###### :  json string 转 dictionary
- (NSDictionary *)dictionary {
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - // Time 时间

#pragma mark - ###### : 秒数 转 日期
// 秒转日期
+ (NSDate *)dateWithSeconds:(NSInteger)seconds{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}
+ (NSString *)dateStringWithSeconds:(NSInteger)seconds Format:(NSString *)format{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:seconds];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format?format:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[formatter stringFromDate:date];
    return dateString;
}
#pragma mark - ###### : 本地时间戳
+(NSString *)localTime{
    NSDate  *date = NSDate.date;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[formatter stringFromDate:date];
    return dateString;
}

#pragma mark - ###### : 时间戳格式
-(NSString *)format:(NSString *)format{
    NSString *dateString=self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSDate *resDate = [formatter dateFromString:dateString];
    
    NSDateFormatter *formatterMore = [[NSDateFormatter alloc] init];
    [formatterMore setDateFormat:format];
    NSString *final=[formatterMore stringFromDate:resDate];
    return final;
}

#pragma mark - ###### : 获取当前时间的字符串
+(NSString *)timeString{
    NSDate *  date=[NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:date];
    return morelocationString;
}
#pragma mark - ###### : 当前时间的秒数
+(NSInteger)currentSeconds{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return [timeString longLongValue];
}
#pragma mark - ###### : 判断 日期 是否是今天
-(BOOL)isToday{
    if (!self||self.length<10) {
        return NO;
    }
    NSString *today=[NSString.localTime substringToIndex:10];
    NSString *timedString=[self substringToIndex:10];
    return [today isEqualToString:timedString];
}
#pragma mark - ###### : 过去多久时间
-(NSString *)timeAgo{
    if (!self||self.length<19) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:self];// 时间
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval:interval];
    NSDate *nowDate = [[NSDate date]dateByAddingTimeInterval:interval];
    //两个时间间隔
    NSTimeInterval timeInterval = [mydate timeIntervalSinceDate:nowDate];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *time;
    if (timeInterval<60) {
        time = [NSString stringWithFormat:NSLocalizedString(@"刚刚", nil)];
    }else if ((temp = timeInterval/60)<60){
        time = [NSString stringWithFormat:@"%ld%@",temp,NSLocalizedString(@"分钟前", nil)];
    }else if ((temp = timeInterval/(60*60))<24){
        time = [NSString stringWithFormat:@"%ld%@",temp,NSLocalizedString(@"小时前", nil)];
    }else if((temp = timeInterval/(24*60*60))<30){
        time = [NSString stringWithFormat:@"%ld%@",temp,NSLocalizedString(@"天前", nil)];
    }else if (((temp = timeInterval/(24*60*60*30)))<12){
        time = [NSString stringWithFormat:@"%ld%@",temp,NSLocalizedString(@"月前", nil)];
    }else {
        temp = timeInterval/(24*60*60*30*12);
        time = [NSString stringWithFormat:@"%ld%@",temp,NSLocalizedString(@"年前", nil)];
    }
    return time;
}
///
#pragma mark - ###### : 判断 日期 是否是n天内
- (BOOL)isTimeInDays:(NSInteger)num{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:self];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0&& cmps.month == 0&& cmps.day < num;
}
#pragma mark - ###### : N天前日期
+(NSString *)getNDayBefore:(NSInteger)n{
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    if(n!=0){
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
    }else{
        theDate = nowDate;
    }
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd hh:MM:ss"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    return the_date_str;
}

#pragma mark - // attribute 部分文字处理
-(NSMutableAttributedString *)rangeText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color{
    if (!text||text.isBlank) {
        return [NSMutableAttributedString.alloc initWithString:self];
    }
    NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = [[mAttr string] rangeOfString:text];
    [mAttr addAttribute:NSForegroundColorAttributeName value:color range:range];//设置字体颜色
    [mAttr addAttribute:NSFontAttributeName value:font range:range];//设置字体字号和字体类别
//    [mAttr addAttribute:NSBaselineOffsetAttributeName value:@((font.lineHeight - [UIFont systemFontOfSize:15].lineHeight)/2 + ((font.descender - [UIFont systemFontOfSize:15].descender))) range:range];//垂直居中
    return mAttr;
}
#pragma mark - // html
- (NSAttributedString *)htmlToAttrbuteString{
    NSDictionary *plp_options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *plp_data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[NSAttributedString alloc] initWithData:plp_data options:plp_options documentAttributes:nil error:nil];
}
- (NSAttributedString *)htmlToAttrbuteStringWithSpace:(CGFloat)space{
    NSDictionary *plp_options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *plp_data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attr=[[NSAttributedString alloc] initWithData:plp_data options:plp_options documentAttributes:nil error:nil];
    NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = space;
    [mAttr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attr.string.length)];
    return mAttr;
}

#pragma mark - ###### : 获取 文字 宽度
- (CGFloat)widthWithSizeHeight:(CGFloat)height font:(UIFont *)font{
    if (!font) {
        font=[UIFont systemFontOfSize:15];
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    CGFloat width = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes: @{NSFontAttributeName :font,
                                                   NSParagraphStyleAttributeName : paragraphStyle}
                                        context:nil].size.width;
    return ceil(width);
    
}
#pragma mark - ###### : 获取 文字 高度
- (CGFloat)heightWithSizeWidth:(CGFloat)width space:(CGFloat)space font:(UIFont *)font{
    if (!font) {
        font=[UIFont systemFontOfSize:15];
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    if (space) {
        [paragraphStyle setLineSpacing:space];
    }
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes: @{NSFontAttributeName :font,
                                                   NSParagraphStyleAttributeName : paragraphStyle}
                                        context:nil].size.height;
    return ceil(height);
    
}

#pragma mark - ###### : 普通字符串 转 换为十六进制字符串
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
#pragma mark - ###### : 整形 转 二进制 字符串
+ (NSString *)binaryStringFromInteger:(NSInteger)value
{
    NSMutableString *string = [NSMutableString string];
    while (value)
    {
        [string insertString:(value & 1)? @"1": @"0" atIndex:0];
        value /= 2;
    }
    while (string.length<8) {
        [string insertString:@"0" atIndex:0];
    }
    return string;
}
#pragma - mark - //上下标
-(NSAttributedString *)superscriptWithText:(NSString *)text Font:(UIFont *)font Up:(BOOL)isUp{
    NSString *infoString=self;
    if (!infoString||infoString.isBlank) {
        return nil;
    }
    NSNumber *tag=isUp?@(font.pointSize-2):@(-1);
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:infoString];
    NSRange range=[infoString rangeOfString:text];
    [attString addAttribute:NSFontAttributeName value:font range:range];
//    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:tag range:range];
    [attString addAttribute:NSBaselineOffsetAttributeName value:tag range:range];
    
    return attString;
}
-(NSAttributedString *)superscriptWithRange:(NSRange)range Font:(UIFont *)font Up:(BOOL)isUp{
    NSString *infoString=self;
    if (!infoString||infoString.isBlank) {
        return nil;
    }
    NSNumber *tag=isUp?@(font.pointSize-2):@(-1);
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:infoString];
    [attString addAttribute:NSFontAttributeName value:font range:range];
//    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:tag range:range];
    [attString addAttribute:NSBaselineOffsetAttributeName value:tag range:range];
    
    return attString;
}
#pragma mark - ###### : plistNameToDictionary
-(NSDictionary *)plistNameToDictionary{
    if (!self||self.isBlank) {
        return  nil;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return  dic;
}
#pragma mark - ###### : 判断 string 是否是 手机号
- (BOOL)isMobile{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[0, 1, 2, 3, 5, 6, 7, 8, 9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,1700,199
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[0-35-9])\\d{8}$";

    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
   
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";

    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
   // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
   // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSString *mobileNum=self;
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - ###### : 判断 string 是否 邮箱格式
-(BOOL)isEmail{
    NSString *email=self;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

    NSPredicate*emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:email];

}

#pragma mark - ###### : 判断 string 是否为空
+ (BOOL) stringIsNull:(NSString *)str {
    if (!str.length){
        return YES;
    }
    return str.isBlank;
}

#pragma mark - ###### : 判断 string 是否为空
-(BOOL)isBlank{
    if (!self||self.length==0||[self isEqualToString:@""]||[self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}
#pragma mark - ###### : 判断 string 是否含有Emoji
-(BOOL)stringContainsEmoji{
    __block BOOL returnValue = NO;
    NSString *string=self;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

#pragma mark - 静态方法 :

#pragma mark - //版本
+(NSString *)appName{
    NSDictionary *infoDictionary = [NSBundle.mainBundle infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}
+(NSString *)appVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *applocalversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return applocalversion;
}
+(NSString *)buildVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    return buildVersion;
}
@end
