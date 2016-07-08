//
//  BaseViewController.h
//  EATFIT
//
//  Created by 刘志刚 on 16/3/4.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)addTitle:(NSString *)title;
- (void)addNavigationButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor isLeft:(BOOL)isLeft imageName:(NSString *)bgImageName selectedImageName:(NSString *)selectedImageName backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action;
@end
