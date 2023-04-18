//
//  MyBaseViewController.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import "MyBaseViewController.h"
#import "MyBaseNavigationController.h"

@interface MyBaseViewController ()

@end

@implementation MyBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultSet];
    [self setupDefault];
    [self setupUI];
    [self bind];
}
-(void)defaultSet{
    UIBarButtonItem* plp_item = [[ UIBarButtonItem alloc] initWithTitle:nil style: UIBarButtonItemStylePlain target: nil action: nil];
    self.navigationItem.backBarButtonItem = plp_item;
    self.navigationController.navigationBar.translucent=NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)panBackEnable:(BOOL)enable{
    MyBaseNavigationController *nav= (MyBaseNavigationController *)self.navigationController;
    [nav panBackEnable:enable];
}
-(void)setupUI{
    
}
-(void)setupDefault{
    
}
-(void)bind{
    
}

-(void)rightBarButtonItemWithTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color ClickAction:(void(^)(void))action{
    UIButton *btn=UIButton.new;
    btn.titleLabel.font=font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:btn];
    self.BlockRightClick = ^{
        action();
    };
}

-(void)rightBarButtonItemWithImage:(UIImage *)image ClickAction:(void(^)(void))action{
    UIButton *btn=UIButton.new;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:btn];
    self.BlockRightClick = ^{
        action();
    };
}
-(void)cancelBarButtonItemWithTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color ClickAction:(void(^)(void))action{
    UIButton *btn=UIButton.new;
    btn.titleLabel.font=font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:btn];
    self.BlockCancelClick = ^{
        action();
    };
}
-(void)cancelBarButtonItemWithImage:(UIImage *)image ClickAction:(void(^)(void))action{
    UIButton *btn=UIButton.new;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:btn];
    self.BlockCancelClick = ^{
        action();
    };
}
-(void)rightBarButtonAction{
    if (self.BlockRightClick) {
        self.BlockRightClick();
    }
}
-(void)cancelBarButtonAction{
    if (self.BlockCancelClick) {
        self.BlockCancelClick();
    }
}
@end
