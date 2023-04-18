//
//  MyBaseViewController.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBaseViewController : UIViewController
@property (nonatomic,copy)void(^BlockRightClick)(void);
@property (nonatomic,copy)void(^BlockCancelClick)(void);
-(void)setupDefault;
-(void)setupUI;
-(void)bind;

- (void)rightBarButtonItemWithTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color ClickAction:(void(^)(void))action;
-(void)rightBarButtonItemWithImage:(UIImage *)image ClickAction:(void(^)(void))action;
- (void)cancelBarButtonItemWithTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color ClickAction:(void(^)(void))action;
-(void)cancelBarButtonItemWithImage:(UIImage *)image ClickAction:(void(^)(void))action;

-(void)panBackEnable:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END
