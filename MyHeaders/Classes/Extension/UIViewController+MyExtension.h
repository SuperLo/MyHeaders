//
//  UIViewController+MyExtension.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MyExtension)

#pragma mark - ###### : 最上层控制器
+(UIViewController *)topViewController;

#pragma mark - ###### : 寻找最上层controller
+(UIViewController *)findTopViewController:(UIViewController *)vc;

#pragma mark - ###### : 设置controller为第二级页面
+(void)setAsSecondViewController:(UIViewController *)vc;

#pragma mark - ###### : popVC
+(void)popVcAnimate:(BOOL)animate;


#pragma mark - ###### : 清除返回标题
-(void)clearBackItemTitle;
#pragma mark - ###### : 推出vc
-(void)pushed;
-(void)pushedAnimate:(BOOL)animate; 
@end

NS_ASSUME_NONNULL_END
