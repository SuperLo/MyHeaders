//
//  UIView+MyExtension.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/17.
//

#import "UIView+MyExtension.h"

@implementation UIView (MyExtension)

#pragma mark - ###### : view identifier
+ (NSString *)identifier{
    return [NSString stringWithFormat:@"%@",[self class]];
    
}

#pragma mark - ###### : 状态栏高度
+(CGFloat)statusBarHeight{
    CGFloat statusHeight=20.0f;
    if(@available(iOS 13.0, *)){
        CGFloat top = UIApplication.sharedApplication.windows.lastObject.safeAreaInsets.top;
        statusHeight = top >= 54 ? 54 : top > 0 ? top : 20.0f;
    }else{
        statusHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    return statusHeight;
}

#pragma mark - ###### : keyWindow
+(UIWindow *)keyWindow{
    //这是 iOS 13之前的写法，在iOS 13之后的版本会出现上面的方法被废弃的提示
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow) {
        if (@available(iOS 13.0, *)) {
            keyWindow = [UIApplication sharedApplication].windows.firstObject;
        }
    }
    if (!keyWindow) {
        if (@available(iOS 15.0, *)) {
            NSSet *set = [[UIApplication sharedApplication] connectedScenes];
            UIWindowScene *windowScene = [set anyObject];
            keyWindow=windowScene.keyWindow;
        }
    }
    return keyWindow;
}


#pragma mark - ###### : 设置view圆角
-(void)setCornerRadius:(CGFloat)radius{
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
}
#pragma mark - ###### : 设置view部分圆角
- (void)viewWithCornerRadius:(CGFloat)radius cornerRect:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
#pragma mark - ###### : 设置view边线颜色、宽度
-(void)setBolderColor:(UIColor *)color Width:(CGFloat)width CornerRadius:(CGFloat)radius{
    self.layer.borderColor=color.CGColor;
    self.layer.borderWidth=width;
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
}
#pragma mark - //base
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint plp_center = self.center;
    plp_center.x = centerX;
    self.center = plp_center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint plp_center = self.center;
    plp_center.y = centerY;
    self.center = plp_center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setSize:(CGSize)size
{
    CGRect plp_frame = self.frame;
    plp_frame.size = size;
    self.frame = plp_frame;
}

- (CGSize)size
{
    return self.frame.size;
}
- (void)setX:(CGFloat)x{
    CGRect plp_frame = self.frame;
    plp_frame.origin.x = x;
    self.frame = plp_frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect plp_frame = self.frame;
    plp_frame.origin.y = y;
    self.frame = plp_frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width
{
    CGRect plp_frame = self.frame;
    plp_frame.size.width = width;
    self.frame = plp_frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect plp_frame = self.frame;
    plp_frame.size.height = height;
    self.frame = plp_frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark - //虚线边框
-(void)dottedBorderWithColor:(UIColor *)color corner:(CGFloat)corner lineWidth:(CGFloat)lineWidth pattener:(NSArray *)dashArray{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = color.CGColor;
    border.fillColor = [UIColor clearColor].CGColor;
    CGFloat width=self.bounds.size.width;
    CGFloat height=self.bounds.size.height;
    CGRect frame=CGRectMake(0, 0, width, height);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:corner];
    border.path = path.CGPath;
    border.frame = frame;
    //线宽(厚度)
    border.lineWidth = lineWidth;
    //虚线的间隔（线长和间隔）
    border.lineDashPattern = dashArray;
    [self.layer addSublayer:border];
}

#pragma mark - ###### : label 默认初始化
+(UILabel *)labelDefaultWithText:(NSString * _Nullable)text Font:(UIFont *)font Color:(UIColor *)color{
    UILabel *label=UILabel.new;
    label.text=text;
    label.font=font;
    label.textColor=color;
    return label;
}

#pragma mark - ###### : view 默认初始化
+(UIView *)viewDefault{
    UIView *view=[UIView.alloc initWithFrame:CGRectZero];
    view.backgroundColor=UIColor.clearColor;
    return view;
}

#pragma mark - ###### : imageView 默认初始化
+(UIImageView *)imageViewDefault{
    UIImageView *imageView=UIImageView.new;
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    return imageView;
}
#pragma mark - ###### : 获取view控制器
- (UIViewController *)viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
