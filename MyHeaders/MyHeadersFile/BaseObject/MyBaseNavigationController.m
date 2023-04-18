//
//  MyBaseNavigationController.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import "MyBaseNavigationController.h"

@interface MyBaseNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic,assign)BOOL canPanBack;

@end

@implementation MyBaseNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
   UIViewController *topVC = self.topViewController;
   return [topVC preferredStatusBarStyle];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.canPanBack=YES;
    // Do any additional setup after loading the view.
    [self setNavBarBgColor:UIColor.whiteColor TintColor:UIColor.blackColor translucent:NO];
    [self setPanAction];
}
//设置透明
-(void)setNavBarBgColor:(UIColor *)color TintColor:(UIColor *)tintColor translucent:(BOOL)translucent{
    self.navigationBar.barTintColor = tintColor;
    self.navigationBar.translucent = translucent;
    self.navigationBar.tintColor = tintColor;
    NSMutableDictionary *plp_textAttrs = [NSMutableDictionary dictionary];
    plp_textAttrs[NSForegroundColorAttributeName] = tintColor;
    plp_textAttrs[NSFontAttributeName] = self.titleFont?:[UIFont systemFontOfSize:15];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = UINavigationBarAppearance.new;
        //添加背景色
        [appperance configureWithOpaqueBackground];
        appperance.backgroundColor = color;
        appperance.shadowImage = translucent?UIImage.new:nil;
        appperance.shadowColor = nil;
        //设置字体颜色
        [appperance setTitleTextAttributes:plp_textAttrs];
        self.navigationBar.standardAppearance = appperance;
        self.navigationBar.scrollEdgeAppearance = appperance;
//        [UINavigationBar.appearance setTintColor:tintColor];
    }else{
        self.navigationBar.titleTextAttributes = plp_textAttrs;
        [self.navigationBar setBackgroundImage:translucent?UIImage.new:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:translucent?UIImage.new:nil];
//        [UINavigationBar.appearance setTintColor:tintColor];
    }
}
- (void)panBackEnable:(BOOL)enable{
    self.canPanBack=enable;
}
-(void)setPanAction{
    // 设置代理
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 创建手势
    UIScreenEdgePanGestureRecognizer *pan =[UIScreenEdgePanGestureRecognizer.alloc initWithTarget:target action:@selector(handleNavigationTransition:)];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置pan手势的代理
    pan.delegate = self;
    pan.edges = UIRectEdgeLeft;
    // 添加手势
    [self.view addGestureRecognizer:pan];
    // 将系统自带的手势覆盖掉
    self.interactivePopGestureRecognizer.enabled = NO;
}
// 表示的意思是:当挡墙控制器是根控制器了,那么就不接收触摸事件,只有当不是根控制器时才需要接收事件.
#pragma mark - UIGestureRecognizerDelegate
// 是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.childViewControllers.count > 1) {
        return self.canPanBack;
    }
    return NO;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
//        [self setupNavTransparent:NO];
//        UIImage *plp_image = [@"plp_Nav_back".plf_image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        UIBarButtonItem *plp_backItem = [[UIBarButtonItem alloc] initWithImage:plp_image style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
//        plp_backItem.tintColor=UIColor.plp_render;
//        viewController.navigationItem.leftBarButtonItem = plp_backItem;
    }
    [super pushViewController:viewController animated:animated];
}
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    if(self.viewControllers.count>1){
        self.topViewController.hidesBottomBarWhenPushed=NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}
@end
