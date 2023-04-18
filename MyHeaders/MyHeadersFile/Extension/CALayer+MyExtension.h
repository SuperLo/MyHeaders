//
//  CALayer+MyExtension.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CALayer (MyExtension)

/// 设置layer阴影
/// - Parameters:
///   - bgColor: 背景颜色
///   - shadowColor: 阴影颜色
///   - offset: 阴影偏移量
///   - opacity: 不透明度、模糊
///   - radius: 圆角
-(void)shadowWithBgColor:(UIColor *)bgColor ShadowColor:(UIColor *)shadowColor Offset:(CGSize)offset Opacity:(CGFloat)opacity Radius:(CGFloat)radius;

/// 清除layer阴影
-(void)clearShadow;
@end

NS_ASSUME_NONNULL_END
