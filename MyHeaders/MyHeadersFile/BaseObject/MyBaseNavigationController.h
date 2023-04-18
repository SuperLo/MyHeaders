//
//  MyBaseNavigationController.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBaseNavigationController : UINavigationController

@property (nonatomic,strong)UIFont *titleFont;
//设置透明
-(void)setNavBarBgColor:(UIColor *)color TintColor:(UIColor *)tintColor translucent:(BOOL)translucent;
-(void)panBackEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
