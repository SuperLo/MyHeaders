//
//  UIView+MyExtension.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MyExtension)

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;

- (CGFloat) maxX;
- (CGFloat) minX;
- (CGFloat) maxY;
- (CGFloat) minY;

#pragma mark - ###### : view identifier
+ (NSString *)identifier;

#pragma mark - ###### : 状态栏高度
+(CGFloat)statusBarHeight;

#pragma mark - ###### : keyWindow
+(UIWindow *)keyWindow;

#pragma mark - ###### : label 默认初始化
+(UILabel *)labelDefaultWithText:(NSString * _Nullable)text Font:(UIFont *)font Color:(UIColor *)color;

#pragma mark - ###### : view 默认初始化
+(UIView *)viewDefault;

#pragma mark - ###### : imageView 默认初始化
+(UIImageView *)imageViewDefault;

#pragma mark - ###### : 获取view控制器
- (UIViewController *)viewController;

#pragma mark - //虚线边框
/// 虚线边框
/// - Parameters:
///   - color: 边框颜色
///   - corner: 圆角
///   - lineWidth: 线宽
///   - dashArray: eg. @[2,3] 宽2 间距3
-(void)dottedBorderWithColor:(UIColor *)color corner:(CGFloat)corner lineWidth:(CGFloat)lineWidth pattener:(NSArray *)dashArray;

@end

NS_ASSUME_NONNULL_END
