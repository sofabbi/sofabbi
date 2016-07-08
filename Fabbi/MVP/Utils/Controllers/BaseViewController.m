//
//  BaseViewController.m
//  EATFIT
//  Created by 刘志刚 on 16/3/4.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "BaseViewController.h"
#import "MyUtils.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"


@interface BaseViewController ()<UIGestureRecognizerDelegate>
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
// 项目上的小圈圈，暂时不用吧
//   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
}
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
- (void)addTitle:(NSString *)title{
    self.title = title;
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0/255.0f green:0/255.0f  blue:0/255.0f alpha:1.0f];
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.barTintColor = RGBA(23, 23, 23, 1);
    // 标题文本属性
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:RGBA(251, 251, 246, 1)};
    // 返回箭头颜色
    self.navigationController.navigationBar.tintColor = RGBA(251, 251, 246, 1);
  
}
- (void)addNavigationButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor isLeft:(BOOL)isLeft imageName:(NSString *)bgImageName selectedImageName:(NSString *)selectedImageName backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action{
    UIButton *btn = [MyUtils createButtonFrame:frame title:title selectTitle:title titleColor:titleColor bgImageName:bgImageName selectImageName:nil backgroundColor: backgroundColor layerCornerRadius:0.f target:target action:action];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}



@end