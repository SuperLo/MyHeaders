//
//  MyConstant.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#ifndef MyConstant_h
#define MyConstant_h

#pragma mark - ###### : DEBUG
#ifdef DEBUG

#define isMyDebug YES

#else

#define isMyDebug NO

#endif

#pragma mark - ###### : WeakSelf

#define WeakObj(o) __weak typeof(o) o##Weak = o;

#pragma mark - ###### : Frame | Size

#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

#pragma mark - ###### : Device

#define is_iphone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define is_iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define is_iPhoneX (SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f && is_iphone)

//基准宽度
#define my_bw (is_iphone?375.0:(is_iPad?450:375.0))

//自动调节尺度
#define FFF(x) ((x)/my_bw)*[UIScreen mainScreen].bounds.size.width

//Status Bar
#define MY_StatusBar_H [UIView statusBarHeight]
#define MY_NavBar_H (is_iPad?50:44)

//Status Bar + NavigationBar

#define MY_Nav_H (CGFloat)(is_iPhoneX?(MY_NavBar_H + MY_StatusBar_H):(is_iPad?74:64))

//TabBar
#define MY_TabBar_H (CGFloat)(is_iPhoneX?(49.0 + 34.0):(49.0))
//top safe area
#define MY_Safe_Top_H (CGFloat)(is_iPhoneX?(44.0):(20))
//bottom safe area
#define MY_Safe_Bottom_H (CGFloat)(is_iPhoneX?(34.0):(0))

#pragma mark - ###### : 颜色

#define MYNumColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MYNumColorAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define MYHexColor(value) [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0xFF00) >> 8)/255.0 blue:(value & 0xFF)/255.0 alpha: 1.0]
#define MYHexColorAlpha(value,a) [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0xFF00) >> 8)/255.0 blue:(value & 0xFF)/255.0 alpha:a]


#endif /* MyConstant_h */
