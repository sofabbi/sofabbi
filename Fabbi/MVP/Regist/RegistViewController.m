//
//  RegistViewController.m
//  Fabbi
//
//  Created by 刘志刚 on 16/6/1.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "RegistViewController.h"
#import "MyUtils.h"
#import "TimerHelper.h"
#import <AFNetworking/AFNetworking.h>
#import "VerifyRegexTool.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface RegistViewController ()<UITextFieldDelegate>{
    UITextField *_phoneNumText;
    UITextField *_registVerifiText;
    UIButton *_registBtn;
    UIImageView *_registBackImageView;
    UITextField *_registPasswordText;
    UILabel *_registVerfiLable;
}

@end

@implementation RegistViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    //自动启动timer
    [TimerHelper timerCountDownWithKey:kTimerKeyRegister tipLabel:_registVerfiLable forceStart:NO];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(255, 255, 255, 1);
    [self createImage];
    [self createBtn];
//    [self createView];

}

- (void)createImage{
    UIImageView *titleView = [MyUtils createImageViewFrame:CGRectMake(152*kScreenWidthP, 78*kScreenWidthP, 70.3*kScreenWidthP, 41.9*kScreenWidthP) imageName:@"logo-firpage.png"];
    [self.view addSubview:titleView];
}

// 创建返回按钮
- (void)createBtn{


}
- (void)registBackBtn:(id)sender{
    if ([_isFirstPage isEqualToString:@"FirstPageViewController"]) {
       [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
//当键盘将要显示时，将底部的view向上移到键盘的上面
-(void)keyboardWillShow:(NSNotification*)notification{
    //通过消息中的信息可以获取键盘的frame对象
    NSValue *keyboardObj = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    // 获取键盘的尺寸,也即是将NSValue转变为CGRect
    CGRect keyrect;
    [keyboardObj getValue:&keyrect];
    CGRect rect=self.view.frame;
    
    //如果键盘的高度大于底部控件到底部的高度，将_scrollView往上移 也即是：-（键盘的高度-底部的空隙）
    if (keyrect.size.height>kScreenHeight-_registBtn.frame.origin.y-_registBtn.frame.size.height) {
        rect.origin.y=-keyrect.size.height+(kScreenHeight-_registBtn.frame.origin.y-_registBtn.frame.size.height);
        self.view.frame = rect;
    }
}

//当键盘将要隐藏时（将原来移到键盘上面的视图还原）
-(void)keyboardWillHide:(NSNotification *)notification{
    CGRect rect=self.view.frame;
    NSValue *keyboardObj = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    // 获取键盘的尺寸,也即是将NSValue转变为CGRect
    CGRect keyrect;
    [keyboardObj getValue:&keyrect];
    rect.origin.y= 0;
    self.view.frame = rect;
}





- (void)HUBshow:(NSString *)lableText{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = lableText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
- (void)loginBtn{
    if ([_isFirstPage isEqualToString:@"FirstPageViewController"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}
- (void)weichatBtn{
    NSLog(@"微信登录");
}






- (void)loginTap{
    [_phoneNumText resignFirstResponder];
    [_registPasswordText resignFirstResponder];
    [_registVerifiText resignFirstResponder];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //取消timer
    
}
@end
