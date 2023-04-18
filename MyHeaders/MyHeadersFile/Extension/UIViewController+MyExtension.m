//
//  UIViewController+MyExtension.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/17.
//

#import "UIViewController+MyExtension.h"
#import "UIView+MyExtension.h"

@implementation UIViewController (MyExtension)


#pragma mark - ###### : 最上层控制器
+(UIViewController *)topViewController {
    UIViewController *resultVC = (UIViewController *)[self findTopViewController:UIView.keyWindow.rootViewController];
    while (resultVC.presentedViewController) {
        resultVC = (UIViewController *)[self findTopViewController:resultVC.presentedViewController];
    }
    if (resultVC) {
        [resultVC.navigationController.navigationBar setShadowImage:UIImage.new];
    }
    return (UIViewController *)resultVC;
}
#pragma mark - ###### : popVC
+(void)popVcAnimate:(BOOL)animate{
    [UIViewController.topViewController.navigationController popViewControllerAnimated:animate];
}
#pragma mark - ###### : 推出vc
-(void)pushed{
    [self pushedAnimate:YES];
}
-(void)pushedAnimate:(BOOL)animate{
    [UIViewController.topViewController.navigationController pushViewController:self animated:animate];
}
#pragma mark - ###### : 寻找最上层controller
+(UIViewController *)findTopViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self findTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self findTopViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
#pragma mark - ###### : 设置controller为第二级页面
+(void)setAsSecondViewController:(UIViewController *)vc{
    UINavigationController *nav = vc.navigationController;
    if(nav.viewControllers.count<2){
        return;
    }
    UIViewController *root = nav.viewControllers[0];
    nav.viewControllers = @[root,vc];
}
#pragma mark - ###### : 清除返回标题
-(void)clearBackItemTitle{
    UIBarButtonItem* plp_item = [[ UIBarButtonItem alloc] initWithTitle:nil style: UIBarButtonItemStylePlain target: nil action: nil];
    self.navigationItem.backBarButtonItem = plp_item;
}
@end
