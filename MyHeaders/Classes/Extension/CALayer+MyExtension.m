//
//  CALayer+MyExtension.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import "CALayer+MyExtension.h"

@implementation CALayer (MyExtension)


/// 设置layer阴影
/// - Parameters:
///   - bgColor: 背景颜色
///   - shadowColor: 阴影颜色
///   - offset: 阴影偏移量
///   - opacity: 不透明度、模糊
///   - radius: 圆角
-(void)shadowWithBgColor:(UIColor *)bgColor ShadowColor:(UIColor *)shadowColor Offset:(CGSize)offset Opacity:(CGFloat)opacity Radius:(CGFloat)radius{
    self.masksToBounds=NO;
    if (bgColor) {
        self.backgroundColor = bgColor.CGColor;
    }
    self.shadowOffset = offset;
    self.shadowOpacity = opacity;
    self.cornerRadius=radius;
    self.shadowColor = shadowColor.CGColor;
}

/// 清除layer阴影
-(void)clearShadow{
    self.masksToBounds=YES;
    self.shadowColor = UIColor.clearColor.CGColor;
}

@end
