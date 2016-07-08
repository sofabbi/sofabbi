
//  OpionbackViewController.m
//  MVP
//  Created by 刘志刚 on 16/4/19.
//  Copyright © 2016年 刘志刚. All rights reserved.

#import "OpionbackViewController.h"
#import "MyUtils.h"
#import "UserStore.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface OpionbackViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIScrollView *opionbackScrollow;
@property (nonatomic,strong) UIButton *equipmentLikeBtn;
@property (nonatomic,strong) UIButton *equipmentJustSoBtn;
@property (nonatomic,strong) UIButton *equipmentDontlikeBtn;
@property (nonatomic,strong) UIButton *designLikeBtn;
@property (nonatomic,strong) UIButton *designJustSoBtn;
@property (nonatomic,strong) UIButton *designDontlikeBtn;
@property (nonatomic,strong) UITextView *opinionTextView;
@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic,strong) UITextField *emailTextField;
@end

@implementation OpionbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"意见反馈";
    
    [self creatNavBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createScrollow];
    
    // 去消息通知中心订阅一条消息（当键盘将要显示时UIKeyboardWillShowNotification）执行相应的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(opinionKeyBoardWillShowWordVctrl:) name:UIKeyboardWillShowNotification object:nil];
    // 去消息通知中心订阅一条消息（当键盘将要隐藏时UIKeyboardWillHideNotification）执行相应的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(opinionKeyBoardWillHideWordVctrl:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)creatNavBar{
    UIView *navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    navigationBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationBarView];
    
    UIView *bavkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    bavkView.userInteractionEnabled = YES;
    [navigationBarView addSubview:bavkView];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(opionBackLeftItem:)];
    [bavkView addGestureRecognizer:backTap];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18*kScreenWidthP, 12*kScreenWidthP, 11*kScreenWidthP, 20*kScreenWidthP)];
    backImageView.image = [UIImage imageNamed:@"back"];
    backImageView.center = CGPointMake(23.5*kScreenWidthP, 22*kScreenWidthP);
    [bavkView addSubview:backImageView];
    
    UIView *senderView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 64, 0, 44, 44)];
    senderView.userInteractionEnabled = YES;
    [navigationBarView addSubview:senderView];
    UITapGestureRecognizer *senderTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(opionBackRightItem:)];
    [senderView addGestureRecognizer:senderTap];
    UILabel *senderL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    senderL.text = @"提交";
    senderL.font = [UIFont systemFontOfSize:17*kScreenWidthP];
    senderL.textColor = RGBA(61, 192, 239, 1);
    senderL.textAlignment = NSTextAlignmentRight;
    [senderView addSubview:senderL];
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 60*kScreenWidthP, 44)];
    titleL.center = CGPointMake(kScreenWidth/2, 22);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"意见反馈";
    titleL.font = [UIFont systemFontOfSize:17*kScreenWidthP];
    [navigationBarView addSubview:titleL];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 43.6*kScreenWidthP, kScreenWidth, 0.4*kScreenWidthP)];
    lineV.backgroundColor = RGBA(34, 34, 34, 0.6);
    [navigationBarView addSubview:lineV];
}
- (void)opinionKeyBoardWillShowWordVctrl:(NSNotification *)notification{
    
    //通过消息中的信息可以获取键盘的frame对象
    NSValue *keyboardObj = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    // 获取键盘的尺寸,也即是将NSValue转变为CGRect
    CGRect keyrect;
    [keyboardObj getValue:&keyrect];
    
    if (keyrect.size.height > kScreenHeight-_emailTextField.frame.size.height-_emailTextField.frame.origin.y) {
        CGAffineTransform translateForm = CGAffineTransformMakeTranslation(0 , kScreenHeight-_emailTextField.frame.size.height-_emailTextField.frame.origin.y-keyrect.size.height-64);
        _opionbackScrollow.transform = translateForm;
    }
}

- (void)opinionKeyBoardWillHideWordVctrl:(NSNotification *)notification{
    //通过消息中的信息可以获取键盘的frame对象
    NSValue *keyboardObj = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    // 获取键盘的尺寸,也即是将NSValue转变为CGRect
    CGRect keyrect;
    [keyboardObj getValue:&keyrect];
    if (keyrect.size.height > kScreenHeight-_emailTextField.frame.size.height-_emailTextField.frame.origin.y) {
        CGAffineTransform translateForm = CGAffineTransformMakeTranslation(0 , -1/2*kScreenHeight+1/2*_emailTextField.frame.size.height+1/2*_emailTextField.frame.origin.y+1/2*keyrect.size.height);
        _opionbackScrollow.transform = translateForm;
    }
}


- (void)createScrollow{
    // 创建滚动视图
    _opionbackScrollow = [MyUtils createScrollViewFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) backgroundColor:RGBA(255, 255, 255, 1) contentSize:CGSizeMake(kScreenWidthP*375, kScreenWidthP*667)];
    [self.view addSubview:_opionbackScrollow];
    
    UITapGestureRecognizer *opionbackScrollowTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(opionbackScrollowTap:)];
    opionbackScrollowTap.numberOfTapsRequired = 1.0;
    opionbackScrollowTap.numberOfTouchesRequired = 1.0;
    [_opionbackScrollow addGestureRecognizer:opionbackScrollowTap];
    
    // 创建意见反馈下面的2条线以及文字
//    UILabel *equipmentLineA = [MyUtils createLabelFrame:CGRectMake(30*kScreenWidthP, 50*kScreenWidthP, 50*kScreenWidthP, 0.5) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
//    [_opionbackScrollow addSubview:equipmentLineA];
    
//    UILabel *equipmentLineB = [MyUtils createLabelFrame:CGRectMake(kScreenWidth-30*kScreenWidthP-50*kScreenWidthP, 50*kScreenWidthP, 50*kScreenWidthP, 0.5) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
//    [_opionbackScrollow addSubview:equipmentLineB];
    
    // 是否喜欢我们推荐的装备
    UILabel *equipmentLabel = [MyUtils createLabelFrame:CGRectMake(84*kScreenWidthP, 30*kScreenWidthP, kScreenWidth-168*kScreenWidthP, 40*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 1) title:@"是否喜欢我们推荐的装备" font:15];
    equipmentLabel.textColor = [MyUtils getColor:@"333333" alpha:1];
    equipmentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    equipmentLabel.textAlignment = NSTextAlignmentCenter;
    equipmentLabel.adjustsFontSizeToFitWidth = YES;
    [_opionbackScrollow addSubview:equipmentLabel];
    
    // 竖线以及喜欢，还行，不喜欢button
    UIView *equipmentBox = [[UIView alloc]initWithFrame:CGRectMake(10*kScreenWidthP, CGRectGetMaxY(equipmentLabel.frame)+15*kScreenWidthP, kScreenWidth - 20*kScreenWidthP, 72*kScreenWidthP)];
    equipmentBox.layer.borderWidth = 0.4*kScreenWidthP;
    equipmentBox.layer.borderColor = RGBA(186, 186, 186, 1).CGColor;
    equipmentBox.layer.masksToBounds = YES;
    equipmentBox.layer.cornerRadius = 3*kScreenWidthP;
    [_opionbackScrollow addSubview:equipmentBox];
    
    UILabel *equipmentVerticalLineA = [MyUtils createLabelFrame:CGRectMake(0, 0, 1*kScreenWidthP, 13*kScreenWidthP) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
    equipmentVerticalLineA.center = CGPointMake((kScreenWidth - 20*kScreenWidthP)/3, 36*kScreenWidthP);
    [equipmentBox addSubview:equipmentVerticalLineA];
    
    UILabel *equipmentVerticalLineB = [MyUtils createLabelFrame:CGRectMake(kScreenWidth*2/3, 100*kScreenWidthP, 1*kScreenWidthP, 13*kScreenWidthP) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
    equipmentVerticalLineB.center = CGPointMake((kScreenWidth - 20*kScreenWidthP)*2/3, 36*kScreenWidthP);
    [equipmentBox addSubview:equipmentVerticalLineB];
    CGFloat equipmentW = equipmentBox.frame.size.width/3;
    
    _equipmentLikeBtn = [MyUtils createButtonFrame:CGRectMake(35*kScreenWidthP, 100*kScreenWidthP, 50*kScreenWidthP, 40*kScreenWidthP) title:@"喜欢" titleColor:[MyUtils getColor:@"999999" alpha:1] backgroundColor:RGBA(255, 255, 255, 0) target:self action:@selector(equipmentLikeBtn:)];
    _equipmentLikeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _equipmentLikeBtn.tintColor = [UIColor clearColor];
    [_equipmentLikeBtn setTitleColor:[MyUtils getColor:@"3DC0EF" alpha:1] forState:UIControlStateSelected];
    _equipmentLikeBtn.selected = YES;
    _isLikeEquipped = 1;
    _equipmentLikeBtn.center = CGPointMake(equipmentW/2, 36*kScreenWidthP);
    [equipmentBox addSubview:_equipmentLikeBtn];
    
    _equipmentJustSoBtn = [MyUtils createButtonFrame:CGRectMake(170*kScreenWidthP, 100*kScreenWidthP, 50*kScreenWidthP, 40*kScreenWidthP) title:@"还行" titleColor:[MyUtils getColor:@"999999" alpha:1] backgroundColor:RGBA(255, 255, 255, 0) target:self action:@selector(equipmentJustSoBtn:)];
    _equipmentJustSoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _equipmentJustSoBtn.tintColor = [UIColor clearColor];
    [_equipmentJustSoBtn setTitleColor:[MyUtils getColor:@"3DC0EF" alpha:1] forState:UIControlStateSelected];
    _equipmentJustSoBtn.center = CGPointMake(equipmentW*3/2, 36*kScreenWidthP);
    [equipmentBox addSubview:_equipmentJustSoBtn];
    
    _equipmentDontlikeBtn = [MyUtils createButtonFrame:CGRectMake(285*kScreenWidthP, 100*kScreenWidthP, 60*kScreenWidthP, 40*kScreenWidthP) title:@"不喜欢" titleColor:[MyUtils getColor:@"999999" alpha:1] backgroundColor:RGBA(255, 255, 255, 0) target:self action:@selector(equipmentDontlikeBtn:)];
    _equipmentDontlikeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _equipmentDontlikeBtn.tintColor = [UIColor clearColor];
    [_equipmentDontlikeBtn setTitleColor:[MyUtils getColor:@"3DC0EF" alpha:1] forState:UIControlStateSelected];
    _equipmentDontlikeBtn.center = CGPointMake(equipmentW*5/2, 36*kScreenWidthP);
    [equipmentBox addSubview:_equipmentDontlikeBtn];
    
    
    
    
     // 创建是否喜欢设计两条横线以及文字
    
   
//     UILabel *designLineA = [MyUtils createLabelFrame:CGRectMake(30*kScreenWidthP, 180*kScreenWidthP, 50*kScreenWidthP, 0.5) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
//    [_opionbackScrollow addSubview:designLineA];
    
    
//    UILabel *designLineB = [MyUtils createLabelFrame:CGRectMake(kScreenWidth-30*kScreenWidthP-50*kScreenWidthP, 180*kScreenWidthP, 50*kScreenWidthP, 0.5) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
//    [_opionbackScrollow addSubview:designLineB];
    
    
    // 是否喜欢我们App的设计
    UILabel *designLabel = [MyUtils createLabelFrame:CGRectMake(84*kScreenWidthP, CGRectGetMaxY(equipmentBox.frame)+30*kScreenWidthP, kScreenWidth-168*kScreenWidthP, 40*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 1) title:@"是否喜欢我们这个APP的设计" font:15];
    designLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    designLabel.textColor = [MyUtils getColor:@"333333" alpha:1];
    designLabel.textAlignment = NSTextAlignmentCenter;
    designLabel.adjustsFontSizeToFitWidth = YES;
    [_opionbackScrollow addSubview:designLabel];
    
    UIView *designBox = [[UIView alloc]initWithFrame:CGRectMake(10*kScreenWidthP, CGRectGetMaxY(designLabel.frame)+15*kScreenWidthP, kScreenWidth - 20*kScreenWidthP, 72*kScreenWidthP)];
    designBox.layer.borderWidth = 0.4*kScreenWidthP;
    designBox.layer.borderColor = RGBA(186, 186, 186, 1).CGColor;
    designBox.layer.masksToBounds = YES;
    designBox.layer.cornerRadius = 3*kScreenWidthP;
    [_opionbackScrollow addSubview:designBox];
    
    // 竖线以及喜欢，还行，不喜欢button
    UILabel *designVerticalLineA = [MyUtils createLabelFrame:CGRectMake(kScreenWidth/3, 220*kScreenWidthP, 1*kScreenWidthP, 13*kScreenWidthP) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
    designVerticalLineA.center = CGPointMake((kScreenWidth - 20*kScreenWidthP)/3, 36*kScreenWidthP);
    [designBox addSubview:designVerticalLineA];
    
    UILabel *designVerticalLineB = [MyUtils createLabelFrame:CGRectMake(kScreenWidth*2/3, 220*kScreenWidthP, 1*kScreenWidthP, 13*kScreenWidthP) title:nil font:10 textAlignment:NSTextAlignmentCenter textColor:nil backgroundColor:RGBA(165, 165, 165, 1) numberOfLines:1 layerCornerRadius:0.f];
    designVerticalLineB.center = CGPointMake((kScreenWidth - 20*kScreenWidthP)*2/3, 36*kScreenWidthP);
    [designBox addSubview:designVerticalLineB];
    
    _designLikeBtn = [MyUtils createButtonFrame:CGRectMake(35*kScreenWidthP, 230*kScreenWidthP, 50*kScreenWidthP, 40*kScreenWidthP) title:@"喜欢" titleColor:[MyUtils getColor:@"999999" alpha:1] backgroundColor:RGBA(255, 255, 255, 0) target:self action:@selector(designLikeBtn:)];
    _designLikeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _designLikeBtn.tintColor = [UIColor clearColor];
    [_designLikeBtn setTitleColor:[MyUtils getColor:@"3DC0EF" alpha:1] forState:UIControlStateSelected];
    _designLikeBtn.selected = YES;
    _isLikeDesign = 1;
    _designLikeBtn.center = CGPointMake(equipmentW/2, 36*kScreenWidthP);
    [designBox addSubview:_designLikeBtn];
    
    _designJustSoBtn = [MyUtils createButtonFrame:CGRectMake(170*kScreenWidthP, 230*kScreenWidthP, 50*kScreenWidthP, 40*kScreenWidthP) title:@"还行" titleColor:[MyUtils getColor:@"999999" alpha:1] backgroundColor:RGBA(255, 255, 255, 0) target:self action:@selector(designJustSoBtn:)];
    _designJustSoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _designJustSoBtn.tintColor = [UIColor clearColor];
    [_designJustSoBtn setTitleColor:[MyUtils getColor:@"3DC0EF" alpha:1] forState:UIControlStateSelected];
    _designJustSoBtn.center = CGPointMake(equipmentW*3/2, 36*kScreenWidthP);
    [designBox addSubview:_designJustSoBtn];
    
    _designDontlikeBtn = [MyUtils createButtonFrame:CGRectMake(285*kScreenWidthP, 230*kScreenWidthP, 60*kScreenWidthP, 40*kScreenWidthP) title:@"不喜欢" titleColor:[MyUtils getColor:@"999999" alpha:1] backgroundColor:RGBA(255, 255, 255, 0) target:self action:@selector(designDontlikeBtn:)];
    _designDontlikeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _designDontlikeBtn.tintColor = [UIColor clearColor];
    [_designDontlikeBtn setTitleColor:[MyUtils getColor:@"3DC0EF" alpha:1] forState:UIControlStateSelected];
    _designDontlikeBtn.center = CGPointMake(equipmentW*5/2, 36*kScreenWidthP);
    [designBox addSubview:_designDontlikeBtn];
    
    _opinionTextView = [[UITextView alloc]initWithFrame:CGRectMake(10*kScreenWidthP, CGRectGetMaxY(designBox.frame)+15*kScreenWidthP, kScreenWidth-20*kScreenWidthP, 160*kScreenWidthP)];
    _opinionTextView.layer.borderColor = RGBA(186, 186, 186, 1).CGColor;
    _opinionTextView.layer.borderWidth = 0.4*kScreenWidthP;
    _opinionTextView.layer.cornerRadius = 3;
    _opinionTextView.font = [UIFont systemFontOfSize:15];
    _opinionTextView.returnKeyType = UIReturnKeyDone;
    _opinionTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _opinionTextView.delegate = self;
    [_opionbackScrollow addSubview:_opinionTextView];
    
    _placeholderLabel = [MyUtils createLabelFrame:CGRectMake(50*kScreenWidthP, 60*kScreenWidthP, _opinionTextView.frame.size.width-100*kScreenWidthP, 40*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 0.f) title:@"请告诉我们你遇到的问题或建议" font:15];
    _placeholderLabel.textColor = [MyUtils getColor:@"999999" alpha:0.5];
    _placeholderLabel.adjustsFontSizeToFitWidth = YES;
    _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    [_opinionTextView addSubview:_placeholderLabel];
    
    _emailTextField = [MyUtils createTextFieldFrame:CGRectMake(10*kScreenWidthP, CGRectGetMaxY(_opinionTextView.frame)+10*kScreenWidthP, kScreenWidth-20*kScreenWidthP, 45*kScreenWidthP) borderStyle:UITextBorderStyleRoundedRect font:15 textColor:[MyUtils getColor:@"999999" alpha:0.5] backgroundColor:RGBA(255, 255, 255, 1)];
    _emailTextField.returnKeyType = UIReturnKeyDone;
    _emailTextField.layer.borderColor = RGBA(186, 186, 186, 1).CGColor;
    _emailTextField.layer.borderWidth = 0.4*kScreenWidthP;
    _emailTextField.layer.cornerRadius = 3;
    _emailTextField.placeholder = @"请填写你的邮箱";
    _emailTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [_emailTextField setValue:[MyUtils getColor:@"999999" alpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    [_emailTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _emailTextField.textAlignment = NSTextAlignmentCenter;
    [_opionbackScrollow addSubview:_emailTextField];
    
}

// 喜欢推荐的设备
- (void)equipmentLikeBtn:(UIButton *)btn{
    _equipmentLikeBtn.selected = YES;
    _equipmentJustSoBtn.selected = NO;
    _equipmentDontlikeBtn.selected = NO;
    _isLikeEquipped = 1;
}

// 推荐的设备还行
- (void)equipmentJustSoBtn:(UIButton *)btn{
    _equipmentLikeBtn.selected = NO;
    _equipmentJustSoBtn.selected = YES;
    _equipmentDontlikeBtn.selected = NO;
    _isLikeEquipped = 2;
}

// 不喜欢推荐的设备
- (void)equipmentDontlikeBtn:(UIButton *)btn{
    _equipmentLikeBtn.selected = NO;
    _equipmentJustSoBtn.selected = NO;
    _equipmentDontlikeBtn.selected = YES;
    _isLikeEquipped = 3;
}
// 喜欢app的设计
- (void)designLikeBtn:(UIButton *)btn{
    _designLikeBtn.selected = YES;
    _designJustSoBtn.selected = NO;
    _designDontlikeBtn.selected = NO;
    _isLikeDesign = 1;
    
}
// 这个app设计的还行
- (void)designJustSoBtn:(UIButton *)btn{
    _isLikeDesign = 2;
    _designLikeBtn.selected = NO;
    _designJustSoBtn.selected = YES;
    _designDontlikeBtn.selected = NO;
    
}
// 不喜欢这个app的设计
- (void)designDontlikeBtn:(UIButton *)btn{
    _isLikeDesign = 3;
    _designLikeBtn.selected = NO;
    _designJustSoBtn.selected = NO;
    _designDontlikeBtn.selected = YES;
    
}

// 导航栏左边返回
- (void)opionBackLeftItem:(id)sender{
 
    [self.navigationController popViewControllerAnimated:YES];
}

// 导航栏右边发送
- (void)opionBackRightItem:(id)sender{
    
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:uid forKey:@"doUserId"];
    [dic setObject:[NSNumber numberWithInt:_isLikeEquipped] forKey:@"isLikeEquipped"];
    [dic setObject:[NSNumber numberWithInt:_isLikeDesign] forKey:@"isLikeDesign"];
    if (_opinionTextView.text.length > 0) {
        [dic setObject:_opinionTextView.text forKey:@"doUserNoets"];
    }
    if (_emailTextField.text.length > 0) {
        [dic setObject:_emailTextField.text forKey:@"doUserEmail"];
    }
    [UserStore POSTWithParams:dic URL:@"api/fed_back.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *resultMessage = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"resultMessage"]];
        [self HUBshow:resultMessage];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
// tap点击，隐藏键盘
- (void)opionbackScrollowTap:(id)sender{
    
    [_opinionTextView resignFirstResponder];
    [_emailTextField resignFirstResponder];
    
}
#pragma mark-textViewdelegate
// 当按return键的时候，隐藏键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //隐藏键盘方法一：如果应用程序需要换行符时，可以设置单击换行时隐藏键盘
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
// 当开始输入的时候，隐藏placeholderLabel
-(void)textViewDidChangeSelection:(UITextView *)textView{
    _placeholderLabel.hidden = YES;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
      [_emailTextField resignFirstResponder];
}

@end
