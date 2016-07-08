//
//  RegLoginScrollow.h
//  MVP
//
//  Created by 刘志刚 on 16/4/25.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUtils.h"
#import "ForgetWordViewController.h"
#import "BindPhoneViewController.h"

@protocol ExitRegLoginDelegate <NSObject>

- (void)exitRegLogin;

@end

@protocol ForgetPasswordDelegate <NSObject>

- (void)forgetPassword;

@end

@protocol WeChatLoginDelegate <NSObject>

- (void)weChatLogin;

@end


@interface RegLoginScrollow : UIScrollView
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
@property (nonatomic,assign) id<ExitRegLoginDelegate>exitdelegate;
@property (nonatomic,assign) id<ForgetPasswordDelegate>forgetPasswordDelegate;
@property (nonatomic,assign) id<WeChatLoginDelegate>weChatLoginDelegate;
@end
