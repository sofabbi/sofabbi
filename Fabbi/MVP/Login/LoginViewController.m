//
//  LoginViewController.m
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "LoginViewController.h"
#import "MyUtils.h"
#import "ForgetWordViewController.h"
#import "RegistViewController.h"
#import "VerifyRegexTool.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "UserInfoModel.h"
#import "MineViewController.h"
#import "TimerHelper.h"
#import "UIImage+ImageEffects.h"
#import "WXApi.h"
#import "AppDelegate.h"
#import "WXApiRequestHandle.h"
#import "WXApiManager.h"
typedef NS_ENUM(NSInteger, TYPEVIEW) {
    FABBI_LOGINVIEW,
    FABBI_RSGISTVIEW
};
@interface LoginViewController ()<UITextFieldDelegate,WXApiManagerDelegate>{
    UITextField *_phoneNumText;
    UITextField *_loginPasswordText;
    UIButton *_loginBtn;
    
    UITextField *_phoneNumberText;
    UITextField *_registVerifiText;
    UIButton *_registBtn;
    UIImageView *_registBackImageView;
    UITextField *_registPasswordText;
    UILabel *_registVerfiLable;
    
}

@property (nonatomic)TYPEVIEW typeView;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    //自动启动timer
    [TimerHelper timerCountDownWithKey:kTimerKeyRegister tipLabel:_registVerfiLable forceStart:NO];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去消息通知中心订阅一条消息（当键盘将要显示时UIKeyboardWillShowNotification）执行相应的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //隐藏键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [WXApiManager sharedManager].delegate = self;
    _registBackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _registBackgroundView.hidden = YES;
    _registBackgroundView.userInteractionEnabled = YES;
    _loginBackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _loginBackgroundView.userInteractionEnabled = YES;
    _loginBackgroundView.hidden = NO;
    [self.view addSubview:_loginBackgroundView];
    [self.view addSubview:_registBackgroundView];
    if ([_isFirstPage isEqualToString:@"FirstPageViewController"]) {
       self.view.backgroundColor = [UIColor whiteColor];
        
    }else{
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
         effe.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [_loginBackgroundView addSubview:effe];
        UIBlurEffect * blur1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView * effe1 = [[UIVisualEffectView alloc]initWithEffect:blur1];
        effe1.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [_registBackgroundView addSubview:effe1];
    }
    [self createImage];
    [self createBtn];
    [self createloginView];
    [self createRegisteView];
}

- (void)createImage{
    
}

// 创建返回按钮
- (void)createBtn{
    

}

// 返回按钮实现功能
- (void)loginBackBtn:(UIButton *)btn{
    if ([_isFirstPage isEqualToString:@"FirstPageViewController"]) {
       [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
#pragma 注册界面
- (void)createloginView{
    UIImageView *titleView = [MyUtils createImageViewFrame:CGRectMake(152*kScreenWidthP, 78*kScreenWidthP, 70.3*kScreenWidthP, 41.9*kScreenWidthP) imageName:@"login_logo"];
    [_loginBackgroundView addSubview:titleView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 23*kScreenWidthP, 50*kScreenWidthP, 50*kScreenWidthP)];
    backView.backgroundColor = [UIColor clearColor];
    [_loginBackgroundView addSubview:backView];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginBackBtn:)];
    [backView addGestureRecognizer:backTap];
    _loginBackImageView = [MyUtils createImageViewFrame:CGRectMake(18*kScreenWidthP, 10*kScreenWidthP, 9*kScreenWidthP, 17*kScreenWidthP) imageName:@"back"];
    [backView addSubview:_loginBackImageView];
    
    // 创建手机号TextField以及下面的线
    _phoneNumText = [[UITextField alloc]initWithFrame:CGRectMake(90*kScreenWidthP, 191*kScreenWidthP, 280*kScreenWidthP, 21*kScreenWidthP)];
    _phoneNumText.borderStyle = UITextBorderStyleNone;
    _phoneNumText.font = [UIFont systemFontOfSize:15*kScreenWidthP];
    // 编辑时方框右边出现叉叉
    _phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑是否清空
    _phoneNumText.clearsOnBeginEditing = YES;
    // 密码的形式
    _phoneNumText.secureTextEntry = NO;
    _phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumText.delegate = self;
    NSString *beforePhone = UserDefaultObjectForKey(FABBI_AUTHORIZATION_PHONE);
    if (beforePhone) {
        _phoneNumText.text = beforePhone;
    }
    [_loginBackgroundView addSubview:_phoneNumText];
    
    // 里面label的颜色
    UILabel *phoneleftLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 191*kScreenWidthP, 45*kScreenWidthP, 21*kScreenWidthP) backgroundColor:[UIColor whiteColor] title:@"手机号" font:15*kScreenWidthP];
    phoneleftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    phoneleftLabel.backgroundColor = [UIColor clearColor];
    phoneleftLabel.textColor = RGBA(34, 34, 34, 0.8);
    
    [_loginBackgroundView addSubview:phoneleftLabel];
    
    UILabel *phoneLabel = [MyUtils createLabelFrame:CGRectMake(40*kScreenWidthP, 219*kScreenWidthP, 295*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(34, 34, 34, 1) title:nil font:0];
    [_loginBackgroundView addSubview:phoneLabel];
    
    // 创建密码TextField以及下面的线
    _loginPasswordText = [[UITextField alloc]initWithFrame:CGRectMake(90*kScreenWidthP, 255*kScreenWidthP, 280*kScreenWidthP, 21*kScreenWidthP)];
    _loginPasswordText.borderStyle = UITextBorderStyleNone;
    _loginPasswordText.font = [UIFont systemFontOfSize:15*kScreenWidthP];
    // 编辑时方框右边出现叉叉
    _loginPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑是否清空
    _loginPasswordText.clearsOnBeginEditing = YES;
    // 密码的形式
    _loginPasswordText.secureTextEntry = YES;
    _loginPasswordText.delegate = self;
    [_loginBackgroundView addSubview:_loginPasswordText];
    
    // 里面label的颜色
    UILabel *loginPassleftLabel = [[UILabel alloc]initWithFrame:CGRectMake(38*kScreenWidthP, 255*kScreenWidthP, 30*kScreenWidthP, 21*kScreenWidthP)];
    loginPassleftLabel.backgroundColor = [UIColor whiteColor];
    loginPassleftLabel.text = @"密码";
    loginPassleftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    loginPassleftLabel.backgroundColor = [UIColor clearColor];
    loginPassleftLabel.textColor = RGBA(34, 34, 34, 0.8);
    [_loginBackgroundView addSubview:loginPassleftLabel];
    
    UILabel *loginPasswordLabel = [MyUtils createLabelFrame:CGRectMake(40*kScreenWidthP, 283*kScreenWidthP,295*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(34,34, 34, 0.8) title:nil font:0];
    [_loginBackgroundView addSubview:loginPasswordLabel];
    
    // 忘记密码
    UIButton *loginForgetPasswordBtn = [MyUtils createButtonFrame:CGRectMake(283*kScreenWidthP, 304*kScreenWidthP, 52*kScreenWidthP, 18*kScreenWidthP) title:@"忘记密码" titleColor:RGBA(70, 194, 238, 1) backgroundColor:nil target:self action:@selector(forgetPasswordVBtn:)];
    [loginForgetPasswordBtn setTitleColor:RGBA(67, 181, 223, 1) forState:UIControlStateNormal];
    loginForgetPasswordBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13*kScreenWidthP];
    loginForgetPasswordBtn.backgroundColor =[UIColor clearColor];
    loginForgetPasswordBtn.titleLabel.backgroundColor = [UIColor clearColor];
    [_loginBackgroundView addSubview:loginForgetPasswordBtn];
    
    // 创建登入按钮
    _loginBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 375*kScreenWidthP, 270*kScreenWidthP, 45*kScreenWidthP) title:@"登入" selectTitle:@"登入" titleColor:RGBA(34, 34, 34, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(0, 0, 0, 0) layerCornerRadius:22.5*kScreenWidthP target:self action:NSSelectorFromString(@"loginAction")];
    _loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    _loginBtn.backgroundColor = [UIColor clearColor];
    _loginBtn.layer.borderWidth = 1*kScreenWidthP;
    _loginBtn.layer.borderColor = RGBA(34, 34, 34, 1).CGColor;
    _loginBtn.layer.masksToBounds = YES;
    [_loginBackgroundView addSubview:_loginBtn];
    
    // 创建注册切换按钮
    UIButton *registBtn = [MyUtils createButtonFrame:CGRectMake(128*kScreenWidthP, 454*kScreenWidthP, 120*kScreenWidthP, 21*kScreenWidthP) title:@"没有账号，去注册" selectTitle:@"没有账号，去注册" titleColor:RGBA(34, 34, 34, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(255, 255, 255, 1) layerCornerRadius:0.f target:self action:NSSelectorFromString(@"toRegistBtn")];
    registBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    registBtn.backgroundColor = [UIColor clearColor];
    [_loginBackgroundView addSubview:registBtn];
    
    UIImageView *wechatImage = [MyUtils createImageViewFrame:CGRectMake(124*kScreenWidthP, 607*kScreenWidthP, 18.5*1.2*kScreenWidthP, 15.6*1.2*kScreenWidthP) imageName:@"login-wechat.png"];
    [_loginBackgroundView addSubview:wechatImage];
    
    // 创建微信登陆按钮
    UIButton *weichatBtn = [MyUtils createButtonFrame:CGRectMake(161*kScreenWidthP, 606*kScreenWidthP, 90*kScreenWidthP, 21*kScreenWidthP) title:@"微信账号登入" selectTitle:@"微信登入" titleColor:RGBA(67, 181, 223, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(255, 255, 255, 1) layerCornerRadius:0.f  target:self action:NSSelectorFromString(@"weichatBtn")];
    weichatBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    weichatBtn.backgroundColor = [UIColor clearColor];
    [_loginBackgroundView addSubview:weichatBtn];
    
    UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:NSSelectorFromString(@"loginTap")];
    loginTap.numberOfTapsRequired = 1.0;
    loginTap.numberOfTouchesRequired = 1.0;
    [_loginBackgroundView addGestureRecognizer:loginTap];
    
    if (![_isFirstPage isEqualToString:@"FirstPageViewController"]) {
        phoneleftLabel.textColor = [UIColor whiteColor];
        loginPassleftLabel.textColor = [UIColor whiteColor];
        _phoneNumText.textColor = [UIColor whiteColor];
        [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.layer.borderWidth = 1*kScreenWidthP;
        _loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        phoneLabel.backgroundColor = [UIColor whiteColor];
        loginPasswordLabel.backgroundColor = [UIColor whiteColor];
        _loginPasswordText.textColor = [UIColor whiteColor];
        _loginBackImageView.image = [UIImage imageNamed:@"exit"];
        _loginBackImageView.frame=CGRectMake(18*kScreenWidthP, 10*kScreenWidthP, 16*kScreenWidthP, 16*kScreenWidthP);
        titleView.image = [UIImage imageNamed:@"login_logo_white"];
        
    }
}

#pragma 注册界面
- (void)createRegisteView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 23*kScreenWidthP, 50*kScreenWidthP, 50*kScreenWidthP)];
    backView.backgroundColor = [UIColor clearColor];
    [_registBackgroundView addSubview:backView];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registBackBtn:)];
    [backView addGestureRecognizer:backTap];
    _registBackImageView = [MyUtils createImageViewFrame:CGRectMake(18*kScreenWidthP, 10*kScreenWidthP, 9*kScreenWidthP, 17*kScreenWidthP) imageName:@"back"];
    [backView addSubview:_registBackImageView];
    
    UIImageView *titleView = [MyUtils createImageViewFrame:CGRectMake(152*kScreenWidthP, 78*kScreenWidthP, 70.3*kScreenWidthP, 41.9*kScreenWidthP) imageName:@"login_logo"];
    [_registBackgroundView addSubview:titleView];
    
    // 创建手机号TextField以及下面的线
    _phoneNumberText = [[UITextField alloc]initWithFrame:CGRectMake(90*kScreenWidthP, 188*kScreenWidthP, 280*kScreenWidthP, 26*kScreenWidthP)];
    _phoneNumberText.borderStyle = UITextBorderStyleNone;
    _phoneNumberText.font = [UIFont systemFontOfSize:15*kScreenWidthP];
    // 编辑时方框右边出现叉叉
    _phoneNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑是否清空
    _phoneNumberText.clearsOnBeginEditing = YES;
    // 密码的形式
    _phoneNumberText.secureTextEntry = NO;
    _phoneNumberText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberText.delegate = self;
    [_registBackgroundView addSubview:_phoneNumberText];
    
    // 手机号里面label
    UILabel *phoneleftLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 191*kScreenWidthP, 45*kScreenWidthP, 21*kScreenWidthP) backgroundColor:[UIColor whiteColor] title:@"手机号" font:15*kScreenWidthP];
    phoneleftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    phoneleftLabel.textColor = RGBA(34, 34, 34, 0.8);
    phoneleftLabel.backgroundColor = [UIColor clearColor];
    [_registBackgroundView addSubview:phoneleftLabel];
    
    UILabel *phoneLabel = [MyUtils createLabelFrame:CGRectMake(40*kScreenWidthP, 219*kScreenWidthP, 295*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(34, 34, 34, 1) title:nil font:0];
    [_registBackgroundView addSubview:phoneLabel];
    
    // 创建验证码TextField以及下面的线
    _registVerifiText = [[UITextField alloc]initWithFrame:CGRectMake(90*kScreenWidthP, 255*kScreenWidthP, 150*kScreenWidthP, 20*kScreenWidthP)];
    _registVerifiText.borderStyle = UITextBorderStyleNone;
    _registVerifiText.font = [UIFont systemFontOfSize:15*kScreenWidthP];
    // 编辑时方框右边出现叉叉
    _registVerifiText.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑是否清空
    _registVerifiText.clearsOnBeginEditing = YES;
    // 密码的形式
    _registVerifiText.secureTextEntry = NO;
    _registVerifiText.delegate = self;
    [_registBackgroundView addSubview:_registVerifiText];
    
    // 里面label的颜色
    UILabel *registVerifileftLabel = [[UILabel alloc]initWithFrame:CGRectMake(38*kScreenWidthP, 255*kScreenWidthP, 45*kScreenWidthP, 20*kScreenWidthP)];
    registVerifileftLabel.backgroundColor = [UIColor clearColor];
    registVerifileftLabel.text = @"验证码";
    registVerifileftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    registVerifileftLabel.textColor = RGBA(34, 34, 34, 0.8);
    [_registBackgroundView addSubview:registVerifileftLabel];
    
    UILabel *registVerifiLabel = [MyUtils createLabelFrame:CGRectMake(40*kScreenWidthP, 283*kScreenWidthP,200*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(34,34, 34, 0.8) title:nil font:0];
    [_registBackgroundView addSubview:registVerifiLabel];
    
    // 验证码
    _registVerfiLable = [MyUtils createLabelFrame:CGRectMake(256*kScreenWidthP, 254*kScreenWidthP, 80*kScreenWidthP, 30*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 1) title:@"获取验证码" font:14*kScreenWidthP];
    _registVerfiLable.userInteractionEnabled = YES;
    _registVerfiLable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13*kScreenWidthP];
    _registVerfiLable.textColor = RGBA(61, 192, 239, 1);
    _registVerfiLable.textAlignment = NSTextAlignmentCenter;
    _registVerfiLable.layer.cornerRadius = 15*kScreenWidthP;
    _registVerfiLable.layer.masksToBounds = YES;
    _registVerfiLable.layer.borderWidth = 1*kScreenWidthP;
    _registVerfiLable.layer.borderColor = RGBA(61, 192, 239, 1).CGColor;
    _registVerfiLable.backgroundColor = [UIColor clearColor];
    [_registBackgroundView addSubview:_registVerfiLable];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registVerifiL)];
    
    [_registVerfiLable addGestureRecognizer:tap];
    // 创建密码TextField以及下面的线
    _registPasswordText = [[UITextField alloc]initWithFrame:CGRectMake(90*kScreenWidthP, 319*kScreenWidthP, 280*kScreenWidthP, 21*kScreenWidthP)];
    _registPasswordText.borderStyle = UITextBorderStyleNone;
    _registPasswordText.font = [UIFont systemFontOfSize:15*kScreenWidthP];
    // 编辑时方框右边出现叉叉
    _registPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑是否清空
    _registPasswordText.clearsOnBeginEditing = YES;
    // 密码的形式
    _registPasswordText.secureTextEntry = NO;
    _registPasswordText.delegate = self;
    [_registBackgroundView addSubview:_registPasswordText];
    
    // 里面label的颜色
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(38*kScreenWidthP, 319*kScreenWidthP, 30*kScreenWidthP, 21*kScreenWidthP)];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.text = @"密码";
    leftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    leftLabel.textColor = RGBA(34, 34, 34, 0.8);
    [_registBackgroundView addSubview:leftLabel];
    
    UILabel *loginPasswordLabel = [MyUtils createLabelFrame:CGRectMake(39*kScreenWidthP, 347*kScreenWidthP,295*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(34,34, 34, 0.8) title:nil font:0];
    [_registBackgroundView addSubview:loginPasswordLabel];
    
    
    // 创建注册按钮
    _registBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 435*kScreenWidthP, 270*kScreenWidthP, 45*kScreenWidthP) title:@"注册" selectTitle:@"注册" titleColor:RGBA(34, 34, 34, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(0, 0, 0, 0) layerCornerRadius:22.5*kScreenWidthP target:self action:NSSelectorFromString(@"registAction")];
    _registBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    _registBtn.layer.borderWidth = 1*kScreenWidthP;
    _registBtn.layer.borderColor = RGBA(34, 34, 34, 1).CGColor;
    _registBtn.layer.masksToBounds = YES;
    [_registBackgroundView addSubview:_registBtn];
    
    // 创建登陆切换按钮
    UIButton *registBtn = [MyUtils createButtonFrame:CGRectMake(128*kScreenWidthP, 514*kScreenWidthP, 120*kScreenWidthP, 21*kScreenWidthP) title:@"已有账号，去登入" selectTitle:@"已有账号，去登入" titleColor:RGBA(34, 34, 34, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(255, 255, 255, 1) layerCornerRadius:0.f target:self action:NSSelectorFromString(@"registBackBtn:")];
    registBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    registBtn.backgroundColor = [UIColor clearColor];
    registBtn.titleLabel.backgroundColor = [UIColor clearColor];
    [_registBackgroundView addSubview:registBtn];
    
    UIImageView *wechatImage = [MyUtils createImageViewFrame:CGRectMake(124*kScreenWidthP, 607*kScreenWidthP, 18.5*1.2*kScreenWidthP, 15.6*1.2*kScreenWidthP) imageName:@"login-wechat.png"];
    [_registBackgroundView addSubview:wechatImage];
    
    // 创建微信登陆按钮
    UIButton *weichatBtn = [MyUtils createButtonFrame:CGRectMake(161*kScreenWidthP, 606*kScreenWidthP, 90*kScreenWidthP, 21*kScreenWidthP) title:@"微信账号登入" selectTitle:@"微信登入" titleColor:RGBA(67, 181, 223, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(255, 255, 255, 1) layerCornerRadius:0.f  target:self action:NSSelectorFromString(@"weichatBtn")];
    weichatBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    weichatBtn.backgroundColor = [UIColor clearColor];
    weichatBtn.titleLabel.backgroundColor = [UIColor clearColor];
    [_registBackgroundView addSubview:weichatBtn];
    
    UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:NSSelectorFromString(@"loginTap")];
    loginTap.numberOfTapsRequired = 1.0;
    loginTap.numberOfTouchesRequired = 1.0;
    [_registBackgroundView addGestureRecognizer:loginTap];
    if (![_isFirstPage isEqualToString:@"FirstPageViewController"]) {
        phoneleftLabel.textColor = [UIColor whiteColor];
        phoneLabel.backgroundColor = [UIColor whiteColor];
        _phoneNumberText.textColor = [UIColor whiteColor];
        registVerifileftLabel.textColor = [UIColor whiteColor];
        registVerifiLabel.backgroundColor = [UIColor whiteColor];
        _registVerifiText.textColor = [UIColor whiteColor];
        leftLabel.textColor = [UIColor whiteColor];
        loginPasswordLabel.backgroundColor = [UIColor whiteColor];
        _registPasswordText.textColor = [UIColor whiteColor];
        _registBtn.layer.borderWidth = 1*kScreenWidthP;
        _registBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registBackImageView.image = [UIImage imageNamed:@"exit"];
        _registBackImageView.frame = CGRectMake(18*kScreenWidthP, 10*kScreenWidthP, 16*kScreenWidthP, 16*kScreenWidthP);
        titleView.image = [UIImage imageNamed:@"login_logo_white"];
    }
}

// 获取验证码
- (void)registVerifiL{
    
    if (_phoneNumberText.text.length > 0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://114.55.43.106/api/getvalieatekey/%@.html",_phoneNumberText.text];
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:_registVerfiLable];
            NSLog(@"成功");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
        }];
        
    }else{
        [self HUBshow:@"请输入手机号"];
    }
    
}

- (void)registBackBtn:(id)sender{
    [self changViewType:FABBI_LOGINVIEW];
}












//当键盘将要显示时，将底部的view向上移到键盘的上面
-(void)keyboardWillShow:(NSNotification*)notification{
    //通过消息中的信息可以获取键盘的frame对象
    NSValue *keyboardObj = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    // 获取键盘的尺寸,也即是将NSValue转变为CGRect
    CGRect keyrect;
    [keyboardObj getValue:&keyrect];
    CGRect rect=self.view.frame;
    if (_typeView == FABBI_LOGINVIEW) {
        //如果键盘的高度大于底部控件到底部的高度，将_scrollView往上移 也即是：-（键盘的高度-底部的空隙）
        if (keyrect.size.height>kScreenHeight-_loginBtn.frame.origin.y-_loginBtn.frame.size.height) {
            rect.origin.y=-keyrect.size.height+(kScreenHeight-_loginBtn.frame.origin.y-_loginBtn.frame.size.height);
            self.view.frame = rect;
        }
    }else{
        //如果键盘的高度大于底部控件到底部的高度，将_scrollView往上移 也即是：-（键盘的高度-底部的空隙）
        if (keyrect.size.height>kScreenHeight-_registBtn.frame.origin.y-_registBtn.frame.size.height) {
            rect.origin.y=-keyrect.size.height+(kScreenHeight-_registBtn.frame.origin.y-_registBtn.frame.size.height);
            self.view.frame = rect;
        }
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


/**
 忘记密码
 */
- (void)forgetPasswordVBtn:(UIButton *)btn{
    
    ForgetWordViewController *forgetVctrl = [[ForgetWordViewController alloc]init];
    if ([_isFirstPage isEqualToString:@""]) {
       [self.navigationController pushViewController:forgetVctrl animated:YES];
    }else{
        [self presentViewController:forgetVctrl animated:YES completion:nil];
    }
    
}

/**
 点击下面的登入
 */
- (void)loginAction{
    BOOL phoneOK = [VerifyRegexTool validatePhone:_phoneNumText.text];
    if (!phoneOK) {
        [self HUBshow:@"请输入手机号"];
        return;
    }
    if (_loginPasswordText.text.length == 0) {
        [self HUBshow:@"输入密码"];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{
                          @"userName":_phoneNumText.text,
                          @"userPassword":_loginPasswordText.text
                          };
    [manager POST:@"http://114.55.43.106/api/user_login.html" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"resultCode"]];
        NSString *resultMessage = [responseObject objectForKey:@"resultMessage"];
        if ([resultCode isEqualToString:@"200"]) {
            UserInfoModel *userInfoModel = [UserInfoModel mj_objectWithKeyValues:responseObject];
            NSNumber *userid = [NSNumber numberWithInt:userInfoModel.userId];
            UserDefaultSetObjectForKey(userid, FABBI_AUTHORIZATION_UID);
            UserDefaultSetObjectForKey(_phoneNumText.text, FABBI_AUTHORIZATION_PHONE);
            [UserInfoModel savePerson:userInfoModel];
            if ([_isFirstPage isEqualToString:@"FirstPageViewController"]) {
                MineViewController *mineVctrl = [[MineViewController alloc]init];
                [self.navigationController pushViewController:mineVctrl animated:YES];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
           
//            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self HUBshow:resultMessage];
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)registAction{
    
    if (_phoneNumberText.text.length == 0) {
        [self HUBshow:@"请输入手机号"];
        return;
    }
    if (_registVerifiText.text.length == 0) {
        [self HUBshow:@"输入验证码"];
        return;
    }
    if (_registPasswordText.text.length == 0) {
        [self HUBshow:@"输入密码"];
        return;
    }
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSNumber *number = [NSNumber numberWithInt:2];
    NSDictionary *dic = @{
                          @"userTel":_phoneNumberText.text,
                          @"valieatekey":_registVerifiText.text,
                          @"userPassword":_registPasswordText.text,
                          @"userFromSource":number
                          };
    [manager POST:@"http://114.55.43.106/api/users_reg.html" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSString *resultCode =  [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"resultCode"]];
        if ([resultCode isEqualToString:@"200"]) {
            UserInfoModel *userInfoModel = [UserInfoModel mj_objectWithKeyValues:responseObject];
            NSNumber *userid = [NSNumber numberWithInt:userInfoModel.userId];
            UserDefaultSetObjectForKey(userid, FABBI_AUTHORIZATION_UID);
            UserDefaultSetObjectForKey(_phoneNumberText.text, FABBI_AUTHORIZATION_PHONE);
            [UserInfoModel savePerson:userInfoModel];
            if ([_isFirstPage isEqualToString:@"FirstPageViewController"]) {
                MineViewController *mineVctrl = [[MineViewController alloc]init];
                [self.navigationController pushViewController:mineVctrl animated:YES];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            NSString *resultMessage = [responseObject objectForKey:@"resultMessage"];
            [self HUBshow:resultMessage];
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
}

/**
 微信登陆
 */


- (void)weichatBtn{
    
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiXinAccessToken];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiXinOpenId];
    // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
    if (accessToken && openID) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiXinRefreshToken];
        NSString *refreshUrlStr = [NSString stringWithFormat:@"%@/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", WX_BASE_URL, kWeiXinAppId, refreshToken];
        [manager GET:refreshUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求reAccess的response = %@", responseObject);
            NSDictionary *refreshDict = [NSDictionary dictionaryWithDictionary:responseObject];
            NSString *reAccessToken = [refreshDict objectForKey:kWeiXinAccessToken];
            // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
            if (reAccessToken) {
                // 更新access_token、refresh_token、open_id
                [[NSUserDefaults standardUserDefaults] setObject:reAccessToken forKey:kWeiXinAccessToken];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:kWeiXinAppId] forKey:kWeiXinOpenId];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:kWeiXinRefreshToken] forKey:kWeiXinRefreshToken];
                [[NSUserDefaults standardUserDefaults] synchronize];
                // 当存在reAccessToken不为空时直接执行AppDelegate中的wechatLoginByRequestForUserInfo方法
                AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
                [appDelegate wechatLoginByRequestForUserInfo:^(NSDictionary *task, NSError *error) {
                    
                }];
                
            }
            else {
                [self wechatLogin];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"用refresh_token来更新accessToken时出错 = %@", error);
        }];
    }
    else {
        [self wechatLogin];
        
    }
}
- (void)wechatLogin{
    NSLog(@"微信");
    [WXApiRequestHandle sendAuthRequestScope: @"snsapi_userinfo"
                                       State:@"app"
                                      OpenID:nil
                            InViewController:self];
//    SendAuthReq *req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo";
//    req.state = @"App";
//    [WXApi sendReq:req];
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
- (void)changViewType:(TYPEVIEW)type{
    if (type == FABBI_LOGINVIEW) {
        [TimerHelper cancelTimerByKey:kTimerKeyRegister];
        _typeView = FABBI_LOGINVIEW;
        _loginBackgroundView.hidden = NO;
        _registBackgroundView.hidden = YES;
    }else{
        _typeView = FABBI_RSGISTVIEW;
        _loginBackgroundView.hidden = YES;
        _registBackgroundView.hidden = NO;
    }
}
// 注册
- (void)toRegistBtn{
    [self changViewType:FABBI_RSGISTVIEW];
}

- (void)loginTap{
    if (_typeView == FABBI_LOGINVIEW) {
        [_phoneNumText resignFirstResponder];
        [_loginPasswordText resignFirstResponder];
    }else{
        [_phoneNumberText resignFirstResponder];
        [_registVerifiText resignFirstResponder];
        [_registPasswordText resignFirstResponder];
    }
    
}

#pragma UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *accessUrlStr = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, kWeiXinAppId, kWeiXinAppSecret, response.code];
    [manager GET:accessUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求access的response = %@", responseObject);
        NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:responseObject];
        NSString *accessToken = [accessDict objectForKey:kWeiXinAccessToken];
        NSString *openID = [accessDict objectForKey:kWeiXinOpenId];
        NSString *refreshToken = [accessDict objectForKey:kWeiXinRefreshToken];
        // 本地持久化，以便access_token的使用、刷新或者持续
        if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kWeiXinAccessToken];
            [[NSUserDefaults standardUserDefaults] setObject:openID forKey:kWeiXinAppId];
            [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:kWeiXinRefreshToken];
            [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
        }
        [self wechatLoginByRequestForUserInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取access_token时出错 = %@", error);
    }];
}
- (void)wechatLoginByRequestForUserInfo{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiXinAccessToken];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiXinAppId];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
    // 请求用户数据
    [manager GET:userUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求用户信息的response = %@", responseObject);
        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取用户信息时出错 = %@", error);
    }];
}

@end
