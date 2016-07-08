
//  Regist&LoginVC.m
//  MVP
//  Created by 刘志刚 on 16/4/15.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "Regist&LoginVC.h"
#import "MyUtils.h"
#import "ForgetWordViewController.h"
#import "BindPhoneViewController.h"

@interface Regist_LoginVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UIScrollView *registScrollow;
@property (nonatomic,strong) UIButton *dissmissBtn;
@property (nonatomic,strong) UIButton *loginSwitchBtn;
@property (nonatomic,strong) UIButton *registSwitchBtn;
@property (nonatomic,strong) UILabel *loginLine;
@property (nonatomic,strong) UILabel *registLine;
@property (nonatomic,strong) UITextField *phoneNumText;
@property (nonatomic,strong) UITextField *loginPasswordText;
@property (nonatomic,strong) UILabel *orLabel;
@property (nonatomic,strong) UIButton *weChatLoginBtn;
@property (nonatomic,strong) UITextField *registVerifiText;
@property (nonatomic,strong) UIButton *registVerifiBtn;
@property (nonatomic,strong) UITextField *registPasswordText;
@property (nonatomic,strong) UILabel *registVerifiLabel;
@property (nonatomic,strong) UILabel *registPasswordLabel;
@property (nonatomic,strong) UILabel *loginPasswordLabel;
@property (nonatomic,strong) UIButton *loginForgetPasswordBtn;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *registBtn;
@end

@implementation Regist_LoginVC

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self createScrollow];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dissmissRegistLogin:) name:@"dissmissRegistLogin" object:nil];
}

- (void)dissmissRegistLogin:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}
/**
 创建滚动视图以及视图上的View
 */
- (void)createScrollow{
    // 创建滚动视图
    _registScrollow = [MyUtils createScrollViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) backgroundColor:RGBA(4, 4, 4, 0.85) contentSize:CGSizeMake(kScreenWidthP*375, kScreenWidthP*667)];
    [self.view addSubview:_registScrollow];
    
    UITapGestureRecognizer *scrollowTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:NSSelectorFromString(@"scrollowTap:")];
    scrollowTap.numberOfTapsRequired = 1.0;
    scrollowTap.numberOfTouchesRequired = 1.0;
    [_registScrollow addGestureRecognizer:scrollowTap];
    
    //退出按钮
    _dissmissBtn = [MyUtils createButtonFrame:CGRectMake(17*kScreenWidthP, 28*kScreenWidthP, 50*kScreenWidthP, 50*kScreenWidthP) title:nil titleColor:nil backgroundColor:nil target:self action:@selector(dissmissBtn:)];
      _dissmissBtn.tintColor = [UIColor whiteColor];
    [_dissmissBtn setImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
    [_registScrollow addSubview:_dissmissBtn];
    
    // 创建登入切换按钮
    _loginSwitchBtn = [MyUtils createButtonFrame:CGRectMake(110*kScreenWidthP, 94*kScreenWidthP, 80*kScreenWidthP, 60*kScreenWidthP) title:@"登入" selectTitle:@"登入" titleColor:RGBA(255, 255, 255, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(4, 4, 4, 0.5) layerCornerRadius:0.f target:self action:NSSelectorFromString(@"loginSwitchBtn:")];
    _loginSwitchBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [_registScrollow addSubview:_loginSwitchBtn];
    
    // 创建登陆下面的线
    _loginLine = [MyUtils createLabelFrame:CGRectMake(10, 60, 60, 2) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(70, 194, 238, 1) numberOfLines:1 layerCornerRadius:0.f];
    [_loginSwitchBtn addSubview:_loginLine];
    
     // 创建注册切换按钮
    _registSwitchBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-150*kScreenWidthP, 94*kScreenWidthP, 80*kScreenWidthP, 60*kScreenWidthP) title:@"注册" selectTitle:@"注册" titleColor:RGBA(255, 255, 255, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(4, 4, 4, 0.5) layerCornerRadius:0.f target:self action:NSSelectorFromString(@"registSwitchBtn:")];
    _registSwitchBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [_registScrollow addSubview:_registSwitchBtn];
    
    // 创建注册下面的线
    _registLine = [MyUtils createLabelFrame:CGRectMake(10, 60, 60, 2) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(70, 194, 238, 1) numberOfLines:1 layerCornerRadius:0.f];
    [self createLoginView];
}

- (void)createLoginView{
   
    // 创建手机号TextField以及下面的线
    _phoneNumText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 190*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleLine textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"手机号" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 0.5) labelTextColor:[UIColor whiteColor] delegate:self];
    [_registScrollow addSubview:_phoneNumText];
    UILabel *phoneLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 240*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [_registScrollow addSubview:phoneLabel];
    
     // 创建密码TextField以及下面的线
    _loginPasswordText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 260*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleLine textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"密码" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 0.5) labelTextColor:[UIColor whiteColor] delegate:self];
    [_registScrollow addSubview:_loginPasswordText];
    
    _loginPasswordLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 310*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [_registScrollow addSubview:_loginPasswordLabel];
    
     // 忘记密码
   _loginForgetPasswordBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-38*kScreenWidthP-80*kScreenWidthP+13*kScreenWidthP, 333*kScreenWidthP, 80*kScreenWidthP, 30*kScreenWidthP) title:@"忘记密码" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 1) target:self action:@selector(forgetPasswordBtn:)];
    [_registScrollow addSubview:_loginForgetPasswordBtn];
    _loginSwitchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, _loginSwitchBtn.titleLabel.bounds.size.width);
    
    
    // 登入button
    _loginBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 400*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 50*kScreenWidthP) title:@"登入" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0.5) target:self action:@selector(loginBtn:)];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_registScrollow addSubview:_loginBtn];
    _loginBtn.layer.borderWidth = 0.8;
    _loginBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    _loginBtn.layer.cornerRadius = 25*kScreenWidthP;
    _loginBtn.layer.masksToBounds = YES;
 
    
    // 中间的或
    _orLabel = [MyUtils createLabelFrame:CGRectMake(kScreenWidth/2-60*kScreenWidthP, 490*kScreenWidthP, 120*kScreenWidthP, 40*kScreenWidthP) backgroundColor:RGBA(4, 4, 4, 0.5) title:@"或" font:15];
    _orLabel.textColor = [MyUtils getColor:@"A5A5A5" alpha:1];
    _orLabel.textAlignment = NSTextAlignmentCenter;
    [_registScrollow addSubview:_orLabel];
    
    
    UIView *lineViewA = [MyUtils createViewFrame:CGRectMake(20*kScreenWidthP, 510*kScreenWidthP, kScreenWidth/2-80*kScreenWidthP, 0.5) backgroundColor:[MyUtils getColor:@"A5A5A5" alpha:1]];
      UIView *lineViewB = [MyUtils createViewFrame:CGRectMake(60*kScreenWidthP+kScreenWidth/2, 510*kScreenWidthP, kScreenWidth/2-80*kScreenWidthP, 0.5) backgroundColor:[MyUtils getColor:@"A5A5A5" alpha:1]];
    [_registScrollow addSubview:lineViewA];
    [_registScrollow addSubview:lineViewB];
    
    
    // 微信登入button
    _weChatLoginBtn =[MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 550*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 50*kScreenWidthP) title:@"微信账号登入" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0.5) target:self action:@selector(weChatLoginBtn:)];
//    [_weChatLoginBtn setImage:[UIImage imageNamed:@"Group 5 Copy.png"] forState:UIControlStateNormal];
    _weChatLoginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _weChatLoginBtn.layer.borderWidth = 0.8;
    _weChatLoginBtn.layer.cornerRadius = 25*kScreenWidthP;
    _weChatLoginBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    [_registScrollow addSubview:_weChatLoginBtn];
    
    
    /**
     验证码textField
     */
    _registVerifiText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 260*kScreenWidthP, kScreenWidth-200*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleLine textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"验证码" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 1) labelTextColor:[UIColor whiteColor] delegate:self];
    
    _registVerifiBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-150*kScreenWidthP, 268*kScreenWidthP, 110*kScreenWidthP, 36*kScreenWidthP) title:@"获取验证码" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 1) target:self action:@selector(getVerifi:)];
    _registVerifiBtn.layer.cornerRadius = 18*kScreenWidthP;
    _registVerifiBtn.layer.masksToBounds = YES;
    _registVerifiBtn.layer.borderWidth = 0.8;
    _registVerifiBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    
    _registVerifiLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 310*kScreenWidthP, kScreenWidth-200*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
   
    
    _registPasswordText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 320*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleLine textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"密码" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 0.5) labelTextColor:[UIColor whiteColor]  delegate:self];
    
   _registPasswordLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 370*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    // 登入button
    _registBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 400*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 50*kScreenWidthP) title:@"注册" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0.5) target:self action:@selector(registBtn:)];
    _registBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _registBtn.layer.borderWidth = 0.8;
    _registBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    _registBtn.layer.cornerRadius = 25*kScreenWidthP;
    _registBtn.layer.masksToBounds = YES;
    
}


/**
  dissmiss退出
 */
- (void)dissmissBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 手势隐藏键盘
 */
- (void)scrollowTap:(id)sender{
    [_phoneNumText resignFirstResponder];
    [_loginPasswordText resignFirstResponder];
    [_registVerifiText resignFirstResponder];
    [_registPasswordText resignFirstResponder];
}

/**
 点击登入切换按钮
 */
- (void)loginSwitchBtn:(UIButton *)btn{
    
    [_registLine removeFromSuperview];
    [_loginSwitchBtn addSubview:_loginLine];
    
    if (_loginPasswordText) {
        [_loginPasswordText removeFromSuperview];
    }
    if (_loginPasswordLabel) {
        [_loginPasswordLabel removeFromSuperview];
    }
    if (_loginBtn ) {
        [_loginBtn removeFromSuperview];
    }
    if (_loginForgetPasswordBtn) {
        [_loginForgetPasswordBtn removeFromSuperview];
    }
    if (_registVerifiText) {
        [_registVerifiText removeFromSuperview];
    }
    if (_registVerifiBtn) {
        [_registVerifiBtn removeFromSuperview];
    }
    if (_registVerifiLabel) {
        [_registVerifiLabel removeFromSuperview];
    }
    if (_loginPasswordText) {
        [_loginPasswordText removeFromSuperview];
    }
    if (_registPasswordText) {
        [_registPasswordLabel removeFromSuperview];
    }
    if (_registPasswordText) {
        [_registPasswordText removeFromSuperview];
    }
    if (_registBtn) {
        [_registBtn removeFromSuperview];
    }
    [self loginView];
    
}
- (void)loginView{

    [_registScrollow addSubview:_loginPasswordText];
    [_registScrollow addSubview:_loginBtn];
    [_registScrollow addSubview:_loginForgetPasswordBtn];
    [_registScrollow addSubview:_loginPasswordLabel];
}

/**
 点击注册切换按钮
 */
- (void)registSwitchBtn:(UIButton *)btn{
    [_loginLine removeFromSuperview];
    [_registSwitchBtn addSubview:_registLine];
    
    if (_loginPasswordText) {
        [_loginPasswordText removeFromSuperview];
    }
    if (_loginPasswordLabel) {
        [_loginPasswordLabel removeFromSuperview];
    }
    if (_loginBtn ) {
        [_loginBtn removeFromSuperview];
    }
    if (_loginForgetPasswordBtn) {
        [_loginForgetPasswordBtn removeFromSuperview];
    }
    if (_registPasswordText) {
        [_registPasswordLabel removeFromSuperview];
    }
    if (_loginBtn){
        [_loginBtn removeFromSuperview];
    }
    [self registView];
}

- (void)registView{
    [_registScrollow addSubview:_registVerifiText];
    [_registScrollow addSubview:_registVerifiBtn];
    [_registScrollow addSubview:_registVerifiLabel];
    [_registScrollow addSubview:_registPasswordText];
    [_registScrollow addSubview:_registPasswordLabel];
    [_registScrollow addSubview:_registBtn];
}

/**
 忘记密码
 */
- (void)forgetPasswordBtn:(UIButton *)btn{
    
    ForgetWordViewController *forgetVctrl = [[ForgetWordViewController alloc]init];
    [self.navigationController pushViewController:forgetVctrl animated:YES];
   
}

/**
 点击获取验证码
 */
- (void)getVerifi:(id)sender{
    
}

/**
 点击下面的登入
 */
- (void)loginBtn:(UIButton *)btn{
    
}
/**
 点击下面的微信登入
 */
- (void)weChatLoginBtn:(UIButton *)btn{
   
    BindPhoneViewController *bindPhoneVctrl = [[BindPhoneViewController alloc]init];
    [self.navigationController pushViewController:bindPhoneVctrl animated:YES];
    
}
/**
 点击下面的注册
 */
- (void)registBtn:(UIButton *)btn{
    
}
#pragma mark - UITextField
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [_phoneNumText resignFirstResponder];
    [_loginPasswordText resignFirstResponder];
    [_registVerifiText resignFirstResponder];
    [_registPasswordText resignFirstResponder];
}
@end
