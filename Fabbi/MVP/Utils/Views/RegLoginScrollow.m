//
//  RegLoginScrollow.m
//  MVP
//
//  Created by 刘志刚 on 16/4/25.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "RegLoginScrollow.h"

@implementation RegLoginScrollow

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = RGBA(4, 4, 4, 0.85);
        self.contentSize = CGSizeMake(kScreenWidthP*375, kScreenWidthP*667);
        
        UITapGestureRecognizer *scrollowTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:NSSelectorFromString(@"scrollowTap:")];
        scrollowTap.numberOfTapsRequired = 1.0;
        scrollowTap.numberOfTouchesRequired = 1.0;
        [self addGestureRecognizer:scrollowTap];
        
        
        //退出按钮
        _dissmissBtn = [MyUtils createButtonFrame:CGRectMake(17*kScreenWidthP, 28*kScreenWidthP, 50*kScreenWidthP, 50*kScreenWidthP) title:nil titleColor:nil backgroundColor:nil target:self action:@selector(dissmissBtn:)];
        _dissmissBtn.tintColor = [UIColor whiteColor];
        [_dissmissBtn setImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
        [self addSubview:_dissmissBtn];
        
        
        // 创建登入切换按钮
        _loginSwitchBtn = [MyUtils createButtonFrame:CGRectMake(110*kScreenWidthP, 94*kScreenWidthP, 80*kScreenWidthP, 60*kScreenWidthP) title:@"登入" selectTitle:@"登入" titleColor:RGBA(255, 255, 255, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(4, 4, 4, 0) layerCornerRadius:0.f target:self action:NSSelectorFromString(@"loginSwitchBtn:")];
        
        _loginSwitchBtn.titleLabel.font = [UIFont systemFontOfSize:24];
        [self addSubview:_loginSwitchBtn];
        
        
        // 创建登陆下面的线
        _loginLine = [MyUtils createLabelFrame:CGRectMake(10, 50, 50, 2) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(70, 194, 238, 1) numberOfLines:1 layerCornerRadius:0.f];
        [_loginSwitchBtn addSubview:_loginLine];
        
        
        // 创建注册切换按钮
        _registSwitchBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-150*kScreenWidthP, 94*kScreenWidthP, 80*kScreenWidthP, 60*kScreenWidthP) title:@"注册" selectTitle:@"注册" titleColor:RGBA(255, 255, 255, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(4, 4, 4, 0) layerCornerRadius:0.f target:self action:NSSelectorFromString(@"registSwitchBtn:")];
        _registSwitchBtn.titleLabel.font = [UIFont systemFontOfSize:24];
        [self addSubview:_registSwitchBtn];
        
        
        // 创建注册下面的线
        _registLine = [MyUtils createLabelFrame:CGRectMake(10, 50, 50, 2) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(70, 194, 238, 1) numberOfLines:1 layerCornerRadius:0.f];
        
        [self createLoginView];
    }
        return self;
}

- (void)createLoginView{
    
    // 创建手机号TextField以及下面的线
    _phoneNumText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 190*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:15 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"手机号" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 0) labelTextColor:[UIColor whiteColor] delegate:self];
    [self addSubview:_phoneNumText];
    UILabel *phoneLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 240*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [self addSubview:phoneLabel];
    
    // 创建密码TextField以及下面的线
    _loginPasswordText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 260*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:15 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"密码" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 0) labelTextColor:[UIColor whiteColor] delegate:self];
    [self addSubview:_loginPasswordText];
    
    _loginPasswordLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 310*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [self addSubview:_loginPasswordLabel];
    
    // 忘记密码
    _loginForgetPasswordBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-38*kScreenWidthP-100*kScreenWidthP, 333*kScreenWidthP, 100*kScreenWidthP, 36*kScreenWidthP) title:@"忘记密码" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0) target:self action:@selector(forgetPasswordBtn:)];
    _loginForgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _loginForgetPasswordBtn.layer.borderWidth = 0.8;
    _loginForgetPasswordBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    _loginForgetPasswordBtn.layer.cornerRadius = 18*kScreenWidthP;
    _loginForgetPasswordBtn.layer.masksToBounds = YES;
    [self addSubview:_loginForgetPasswordBtn];
   
    
    // 登入button
    _loginBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 400*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 50*kScreenWidthP) title:@"登入" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0) target:self action:@selector(loginBtn:)];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_loginBtn];
    _loginBtn.layer.borderWidth = 0.8;
    _loginBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    _loginBtn.layer.cornerRadius = 25*kScreenWidthP;
    _loginBtn.layer.masksToBounds = YES;
    
    
    // 中间的或
    _orLabel = [MyUtils createLabelFrame:CGRectMake(kScreenWidth/2-60*kScreenWidthP, 490*kScreenWidthP, 120*kScreenWidthP, 40*kScreenWidthP) backgroundColor:RGBA(4, 4, 4, 0) title:@"或" font:15];
    _orLabel.textColor = [MyUtils getColor:@"A5A5A5" alpha:1];
    _orLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_orLabel];
    
    
    UIView *lineViewA = [MyUtils createViewFrame:CGRectMake(20*kScreenWidthP, 510*kScreenWidthP, kScreenWidth/2-80*kScreenWidthP, 1) backgroundColor:[MyUtils getColor:@"A5A5A5" alpha:1]];
    UIView *lineViewB = [MyUtils createViewFrame:CGRectMake(60*kScreenWidthP+kScreenWidth/2, 510*kScreenWidthP, kScreenWidth/2-80*kScreenWidthP, 1) backgroundColor:[MyUtils getColor:@"A5A5A5" alpha:1]];
    [self addSubview:lineViewA];
    [self addSubview:lineViewB];
    
    
    // 微信登入button
    _weChatLoginBtn =[MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 550*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 50*kScreenWidthP) title:@"微信账号登入" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0) target:self action:@selector(weChatLoginBtn:)];
        [_weChatLoginBtn setImage:[UIImage imageNamed:@"WeChat.png"] forState:UIControlStateNormal];
    _weChatLoginBtn.tintColor = RGBA(73, 182, 222, 1);
    _weChatLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _weChatLoginBtn.layer.borderWidth = 0.8;
    _weChatLoginBtn.layer.cornerRadius = 25*kScreenWidthP;
    _weChatLoginBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    [self addSubview:_weChatLoginBtn];
    
    /**
     验证码textField
     */
    _registVerifiText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 260*kScreenWidthP, kScreenWidth-200*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"验证码" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 0) labelTextColor:[UIColor whiteColor] delegate:self];
    
    _registVerifiBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-150*kScreenWidthP, 268*kScreenWidthP, 110*kScreenWidthP, 36*kScreenWidthP) title:@"获取验证码" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0) target:self action:@selector(getVerifi:)];
    _registVerifiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _registVerifiBtn.layer.cornerRadius = 18*kScreenWidthP;
    _registVerifiBtn.layer.masksToBounds = YES;
    _registVerifiBtn.layer.borderWidth = 0.8;
    _registVerifiBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    
    _registVerifiLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 310*kScreenWidthP, kScreenWidth-200*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    
    _registPasswordText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 320*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"密码" textColor:RGBA(255, 255, 255, 1) backgroundColor:RGBA(4, 4, 4, 0) labelTextColor:[UIColor whiteColor]  delegate:self];
    
    _registPasswordLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 370*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    // 登入button
    _registBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 400*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 50*kScreenWidthP) title:@"注册" titleColor:RGBA(70, 194, 238, 1) backgroundColor:RGBA(4, 4, 4, 0) target:self action:@selector(registBtn:)];
    _registBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _registBtn.layer.borderWidth = 0.8;
    _registBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    _registBtn.layer.cornerRadius = 25*kScreenWidthP;
    _registBtn.layer.masksToBounds = YES;
}

/**
 dissmiss退出
 */
- (void)dissmissBtn:(id)sender{
    [self.exitdelegate exitRegLogin];
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
    
    [self addSubview:_loginPasswordText];
    [self addSubview:_loginBtn];
    [self addSubview:_loginForgetPasswordBtn];
    [self addSubview:_loginPasswordLabel];
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
    [self addSubview:_registVerifiText];
    [self addSubview:_registVerifiBtn];
    [self addSubview:_registVerifiLabel];
    [self addSubview:_registPasswordText];
    [self addSubview:_registPasswordLabel];
    [self addSubview:_registBtn];
}

/**
 忘记密码
 */
- (void)forgetPasswordBtn:(UIButton *)btn{

    [self.forgetPasswordDelegate forgetPassword];
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

    [self.weChatLoginDelegate weChatLogin];
     
    
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
