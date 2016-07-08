//
//  BindPhoneViewController.m
//  MVP
//
//  Created by 刘志刚 on 16/4/21.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "MyUtils.h"
@interface BindPhoneViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *phoneNumText;
@property (nonatomic,strong) UILabel *phoneNumLineLabel;
@property (nonatomic,strong) UITextField *loginPasswordText;
@property (nonatomic,strong) UITextField *getVerifiText;
@property (nonatomic,strong) UIButton *getVerifiBtn;
@property (nonatomic,strong) UILabel *getVerifiLabel;
@property (nonatomic,strong) UIButton *completeBtn;
@end

@implementation BindPhoneViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定手机号";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    
    // 去消息通知中心订阅一条消息（当键盘将要显示时UIKeyboardWillShowNotification）执行相应的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bindPhoneKeyBoardWillShowWordVctrl:) name:UIKeyboardWillShowNotification object:nil];
    // 去消息通知中心订阅一条消息（当键盘将要隐藏时UIKeyboardWillHideNotification）执行相应的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bindPhoneKeyBoardHideShowWordVctrl:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)bindPhoneKeyBoardWillShowWordVctrl:(NSNotification *)notification{
    
    //通过消息中的信息可以获取键盘的frame对象
    NSValue *keyboardObj = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    // 获取键盘的尺寸,也即是将NSValue转变为CGRect
    CGRect keyrect;
    [keyboardObj getValue:&keyrect];
    
    if (keyrect.size.height > kScreenHeight-_completeBtn.frame.size.height-_completeBtn.frame.origin.y) {
        CGAffineTransform translateForm = CGAffineTransformMakeTranslation(0 , kScreenHeight-_completeBtn.frame.size.height-_completeBtn.frame.origin.y-keyrect.size.height);
        self.view .transform = translateForm;
    }
}

- (void)bindPhoneKeyBoardHideShowWordVctrl:(NSNotification *)notification{
    //通过消息中的信息可以获取键盘的frame对象
    NSValue *keyboardObj = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    // 获取键盘的尺寸,也即是将NSValue转变为CGRect
    CGRect keyrect;
    [keyboardObj getValue:&keyrect];
    if (keyrect.size.height > kScreenHeight-_completeBtn.frame.size.height-_completeBtn.frame.origin.y) {
        CGAffineTransform translateForm = CGAffineTransformMakeTranslation(0 , -1/2*kScreenHeight+1/2*_completeBtn.frame.size.height+1/2*_completeBtn.frame.origin.y+1/2*keyrect.size.height);
        self.view .transform = translateForm;
    }
}


- (void)createView{
    // 创建手机号TextField以及下面的线
    _phoneNumText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 64+70*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"手机号" textColor:RGBA(0, 0, 0, 1) backgroundColor:RGBA(255, 255, 255, 1) labelTextColor:[MyUtils getColor:@"666666" alpha:1] delegate:self];
    [self.view addSubview:_phoneNumText];
    
    _phoneNumLineLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 64+121*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [self.view addSubview:_phoneNumLineLabel];
    
    // 创建验证码TextField以及下面的线
    _getVerifiText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 64+133*kScreenWidthP, kScreenWidth-200*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:18 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"验证码" textColor:RGBA(0, 0, 0, 1) backgroundColor:RGBA(255, 255, 255, 1) labelTextColor:[MyUtils getColor:@"666666" alpha:1] delegate:self];
    [self.view addSubview:_getVerifiText];
    
    _getVerifiBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-140*kScreenWidthP, 64+140*kScreenWidthP, 100*kScreenWidthP, 34*kScreenWidthP) title:@"获取验证码" titleColor:[MyUtils getColor:@"3DC0EF" alpha:1] backgroundColor:RGBA(255, 255, 255, 1) target:self action:@selector(getBindPhoneVerifi:)];
    _getVerifiBtn.layer.cornerRadius = 17*kScreenWidthP;
    _getVerifiBtn.layer.masksToBounds = YES;
    _getVerifiBtn.layer.borderWidth = 0.8;
    _getVerifiBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
    _getVerifiBtn.titleLabel.font =[UIFont systemFontOfSize:13];
    [self.view addSubview:_getVerifiBtn];
    
    _getVerifiLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 64+184*kScreenWidthP, kScreenWidth-190*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [self.view addSubview:_getVerifiLabel];
    
    _completeBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 64+234*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 50*kScreenWidthP) title:@"完成" titleColor:[MyUtils getColor:@"3DC0EF" alpha:1] backgroundColor:RGBA(255, 255, 255, 1) target:self action:@selector(completeBtn:)];
    _completeBtn.layer.cornerRadius = 25*kScreenWidthP;
    _completeBtn.layer.masksToBounds = YES;
    _completeBtn.layer.borderWidth = 0.8;
    _completeBtn.layer.borderColor = [MyUtils getColor:@"3DC0EF" alpha:1].CGColor;
    [self.view addSubview:_completeBtn];
}
/**
 获取验证码
 */
/****************发送一个获取验证码post请求*********************/
- (void)getBindPhoneVerifi:(id)sender{
    
}
/**
 完成,回到当前页面
 */
/****************发送一个完成的post请求*********************/
- (void)completeBtn:(id)sender{
    
    if (_phoneNumText.text.length == 0 || _getVerifiText.text.length == 0) {
        UIAlertView *textFieldEmpty = [[UIAlertView alloc]initWithTitle:@"手机号或验证码不能为空" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新验证", nil];
        [textFieldEmpty show];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"state"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark-alertView协议方法,退出登录
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            return;
            break;
            
        default:{
            [_phoneNumText becomeFirstResponder];
        }
            break;
    }
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneNumText resignFirstResponder];
    [_loginPasswordText resignFirstResponder];
    [_getVerifiText resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_phoneNumText resignFirstResponder];
    [_loginPasswordText resignFirstResponder];
    [_getVerifiText resignFirstResponder];
}
@end
