//
//  UIFont+MyExtension.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import "UIFont+MyExtension.h"

@implementation UIFont (MyExtension)

+(UIFont *)myRegularSize:(CGFloat)size{
    NSString *fontName=[NSUserDefaults.standardUserDefaults objectForKey:@"myFontName_Regular"];
    if(fontName){
        return [UIFont fontWithName:fontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}
+(UIFont *)mySemiboldSize:(CGFloat)size{
    NSString *fontName=[NSUserDefaults.standardUserDefaults objectForKey:@"myFontName_Semibold"];
    if(fontName){
        return [UIFont fontWithName:fontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}
+(UIFont *)myMediumSize:(CGFloat)size{
    NSString *fontName=[NSUserDefaults.standardUserDefaults objectForKey:@"myFontName_Medium"];
    if(fontName){
        return [UIFont fontWithName:fontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}
+(UIFont *)myLightSize:(CGFloat)size{
    NSString *fontName=[NSUserDefaults.standardUserDefaults objectForKey:@"myFontName_Light"];
    if(fontName){
        return [UIFont fontWithName:fontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}
+(UIFont *)myUltralightSize:(CGFloat)size{
    NSString *fontName=[NSUserDefaults.standardUserDefaults objectForKey:@"myFontName_Ultralight"];
    if(fontName){
        return [UIFont fontWithName:fontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}
+(UIFont *)myThinSize:(CGFloat)size{
    NSString *fontName=[NSUserDefaults.standardUserDefaults objectForKey:@"myFontName_Thin"];
    if(fontName){
        return [UIFont fontWithName:fontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}
#pragma mark - ###### : 设置
+(void)setDefaultFontName_Regular:(NSString *)fontName{
    if(fontName){
        [NSUserDefaults.standardUserDefaults setObject:fontName forKey:@"myFontName_Regular"];
    }
}
+(void)setDefaultFontName_Semibold:(NSString *)fontName{
    if(fontName){
        [NSUserDefaults.standardUserDefaults setObject:fontName forKey:@"myFontName_Semibold"];
    }
}
+(void)setDefaultFontName_Medium:(NSString *)fontName{
    if(fontName){
        [NSUserDefaults.standardUserDefaults setObject:fontName forKey:@"myFontName_Medium"];
    }
}
+(void)setDefaultFontName_Light:(NSString *)fontName{
    if(fontName){
        [NSUserDefaults.standardUserDefaults setObject:fontName forKey:@"myFontName_Light"];
    }
}

+(void)setDefaultFontName_Ultralight:(NSString *)fontName{
    if(fontName){
        [NSUserDefaults.standardUserDefaults setObject:fontName forKey:@"myFontName_Ultralight"];
    }
}

+(void)setDefaultFontName_Thin:(NSString *)fontName{
    if(fontName){
        [NSUserDefaults.standardUserDefaults setObject:fontName forKey:@"myFontName_Thin"];
    }
}


@end
