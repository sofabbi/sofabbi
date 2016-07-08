//
//  ForgetWordViewController.m
//  MVP
//
//  Created by 刘志刚 on 16/4/20.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "ForgetWordViewController.h"
#import "MyUtils.h"
#import "TimerHelper.h"
#import "VerifyRegexTool.h"
#import <AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface ForgetWordViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UITextField *phoneNumText;
@property (nonatomic,strong) UILabel *phoneNumLineLabel;
@property (nonatomic,strong) UITextField *loginPasswordText;
@property (nonatomic,strong) UITextField *getVerifiText;
@property (nonatomic,strong) UIButton *getVerifiBtn;
@property (nonatomic,strong) UILabel *getVerifiLabel;
@property (nonatomic,strong) UITextField *passWordText;
@property (nonatomic,strong) UILabel *paaWordLabel;
@property (nonatomic,strong) UIButton *completeBtn;
@property (nonatomic,strong) UIScrollView *forgetScrollowVctrl;
@property (nonatomic,strong) UILabel *registVerfiLable;
@end

@implementation ForgetWordViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //自动启动timer
    [TimerHelper timerCountDownWithKey:kTimerKeyRegister tipLabel:_registVerfiLable forceStart:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    [self createBtn];
    UIBarButtonItem *forgetLeftItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Group 10.png"] style:UIBarButtonItemStyleDone target:self action:@selector(forgetLeftItem:)];
    self.navigationItem.leftBarButtonItem = forgetLeftItem;
    // 去消息通知中心订阅一条消息（当键盘将要显示时UIKeyboardWillShowNotification）执行相应的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(forgetKeyBoardWillShowWordVctrl:) name:UIKeyboardWillShowNotification object:nil];
    // 去消息通知中心订阅一条消息（当键盘将要隐藏时UIKeyboardWillHideNotification）执行相应的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(forgetKeyBoardWillHideWordVctrl:) name:UIKeyboardWillHideNotification object:nil];
}
// 创建返回按钮
- (void)createBtn{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 23*kScreenWidthP, 30*kScreenWidthP, 30*kScreenWidthP)];
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginBackBtn:)];
    [backView addGestureRecognizer:backTap];
    _registBackImageView = [MyUtils createImageViewFrame:CGRectMake(18*kScreenWidthP, 10*kScreenWidthP, 8.9*kScreenWidthP, 17.8*kScreenWidthP) imageName:@"back"];
    [backView addSubview:_registBackImageView];
    
}
// 返回按钮实现功能
- (void)loginBackBtn:(UIButton *)btn{
    if ([_isFirstPage isEqualToString:@"FirstPageViewController"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)forgetKeyBoardWillShowWordVctrl:(NSNotification *)notification{
    
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

- (void)forgetKeyBoardWillHideWordVctrl:(NSNotification *)notification{
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

- (void)forgetLeftItem:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
  
}

- (void)createView{
    // 创建手机号TextField以及下面的线
    _phoneNumText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 64+70*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:15 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"手机号" textColor:RGBA(0, 0, 0, 1) backgroundColor:RGBA(255, 255, 255, 1) labelTextColor:[MyUtils getColor:@"666666" alpha:1] delegate:self];
    [self.view addSubview:_phoneNumText];
    
   _phoneNumLineLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 64+121*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [self.view addSubview:_phoneNumLineLabel];
    
    
     // 创建验证码TextField以及下面的线
    _getVerifiText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 64+133*kScreenWidthP, kScreenWidth-200*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:15 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"验证码" textColor:RGBA(0, 0, 0, 1) backgroundColor:RGBA(255, 255, 255, 1) labelTextColor:[MyUtils getColor:@"666666" alpha:1] delegate:self];
    [self.view addSubview:_getVerifiText];
    
    // 验证码
    _registVerfiLable = [MyUtils createLabelFrame:CGRectMake(kScreenWidth-140*kScreenWidthP, 64+140*kScreenWidthP, 100*kScreenWidthP, 34*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 1) title:@"获取验证码" font:14*kScreenWidthP];
    _registVerfiLable.userInteractionEnabled = YES;
    _registVerfiLable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13*kScreenWidthP];
    _registVerfiLable.textColor = RGBA(61, 192, 239, 1);
    _registVerfiLable.textAlignment = NSTextAlignmentCenter;
    _registVerfiLable.layer.cornerRadius = 15*kScreenWidthP;
    _registVerfiLable.layer.masksToBounds = YES;
    _registVerfiLable.layer.borderWidth = 1*kScreenWidthP;
    _registVerfiLable.layer.borderColor = RGBA(61, 192, 239, 1).CGColor;
    
    [self.view addSubview:_registVerfiLable];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getForgetVerifi:)];
   [_registVerfiLable addGestureRecognizer:tap];
    
//    _getVerifiBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth-140*kScreenWidthP, 64+140*kScreenWidthP, 100*kScreenWidthP, 34*kScreenWidthP) title:@"获取验证码" titleColor:[MyUtils getColor:@"3DC0EF" alpha:1] backgroundColor:RGBA(255, 255, 255, 1) target:self action:@selector(getForgetVerifi:)];
//    _getVerifiBtn.layer.cornerRadius = 17*kScreenWidthP;
//    _getVerifiBtn.layer.masksToBounds = YES;
//    _getVerifiBtn.layer.borderWidth = 0.8;
//    _getVerifiBtn.layer.borderColor = RGBA(70, 194, 238, 1).CGColor;
//    _getVerifiBtn.titleLabel.font =[UIFont systemFontOfSize:13];
//    [self.view addSubview:_getVerifiBtn];
    
    _getVerifiLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 64+184*kScreenWidthP, kScreenWidth-190*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [self.view addSubview:_getVerifiLabel];
    
    
     // 创建密码的TextField以及下面的线
    _passWordText = [MyUtils createTextFieldFrame:CGRectMake(38*kScreenWidthP, 64+196*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 40*kScreenWidthP) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft font:15 placeholder:nil clearButtonMode:UITextFieldViewModeWhileEditing leftViewMode:UITextFieldViewModeAlways clearsOnBeginEditing:YES secureTextEntry:NO leftViewTitle:@"重置密码" textColor:RGBA(0, 0, 0, 1) backgroundColor:RGBA(255, 255, 255, 1) labelTextColor:[MyUtils getColor:@"666666" alpha:1] delegate:self];
    [self.view addSubview:_passWordText];
    
    _paaWordLabel = [MyUtils createLabelFrame:CGRectMake(38*kScreenWidthP, 64+247*kScreenWidthP, kScreenWidth-76*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(165, 165, 165, 1) title:nil font:0];
    [self.view addSubview:_paaWordLabel];
    
    _completeBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, 64+297*kScreenWidthP, kScreenWidth-106*kScreenWidthP, 45*kScreenWidthP) title:@"确定" titleColor:[UIColor blackColor] backgroundColor:RGBA(255, 255, 255, 1) target:self action:@selector(completeBtn:)];
    _completeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    _completeBtn.layer.cornerRadius = 25*kScreenWidthP;
    _completeBtn.layer.masksToBounds = YES;
    _completeBtn.layer.borderWidth = 0.8;
    _completeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_completeBtn];
                       
}
/**
 获取验证码
 */
/****************发送一个获取验证码post请求*********************/
- (void)getForgetVerifi:(id)sender{
    BOOL phoneOK = [VerifyRegexTool validatePhone:_phoneNumText.text];
    if (phoneOK) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://114.55.43.106/api/getvalieatekey/%@.html",_phoneNumText.text];
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

/**
 完成,回到当前页面
 */
/****************发送一个完成的post请求*********************/
- (void)completeBtn: (UIButton *)btn{
    BOOL phoneOK = [VerifyRegexTool validatePhone:_phoneNumText.text];
    if (!phoneOK) {
        [self HUBshow:@"请输入手机号"];
        return;
    }
    if (_getVerifiText.text.length == 0) {
        [self HUBshow:@"输入验证码"];
        return;
    }
    if (_loginPasswordText.text.length == 0) {
        [self HUBshow:@"输入密码"];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSNumber *number = [NSNumber numberWithInt:2];
    NSDictionary *dic = @{
                          @"userTel":_phoneNumText.text,
                          @"valieatekey":_getVerifiText.text,
                          @"userPassword":_loginPasswordText.text,
                          @"userFromSource":number
                          };
    [manager POST:@"http://192.168.0.192/api/users_reg.html" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    if (_phoneNumText.text.length == 0 || _getVerifiText.text.length == 0 || _passWordText.text.length == 0) {
        UIAlertView *textFieldEmpty = [[UIAlertView alloc]initWithTitle:@"所有的都为必填项，请补充完整" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新验证", nil];
        [textFieldEmpty show];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"state"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"dissmissRegistLogin" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
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

#pragma mark-textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_passWordText resignFirstResponder];
    [_phoneNumText resignFirstResponder];
    [_loginPasswordText resignFirstResponder];
    [_getVerifiText resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_passWordText resignFirstResponder];
    [_phoneNumText resignFirstResponder];
    [_loginPasswordText resignFirstResponder];
    [_getVerifiText resignFirstResponder];
}
@end
