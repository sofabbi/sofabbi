//
//  UserAgreeViewController.m
//  MVP
//
//  Created by 刘志刚 on 16/4/19.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "UserAgreeViewController.h"
#import <TYAttributedLabel/TYAttributedLabel.h>
@interface UserAgreeViewController ()

@end

@implementation UserAgreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
     self.view.backgroundColor = [UIColor whiteColor];

    [self creatNavBar];
    [self initUI];
}
- (void)creatNavBar{
    UIView *navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    navigationBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationBarView];
    UIView *bavkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    bavkView.userInteractionEnabled = YES;
    [navigationBarView addSubview:bavkView];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userAgreeLeftItem:)];
    [bavkView addGestureRecognizer:backTap];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18*kScreenWidthP, 12*kScreenWidthP, 11*kScreenWidthP, 20*kScreenWidthP)];
    backImageView.image = [UIImage imageNamed:@"back"];
    backImageView.center = CGPointMake(23.5*kScreenWidthP, 22*kScreenWidthP);
    [bavkView addSubview:backImageView];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 60*kScreenWidthP, 44)];
    titleL.center = CGPointMake(kScreenWidth/2, 22);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"用户协议";
    titleL.font = [UIFont systemFontOfSize:17*kScreenWidthP];
    [navigationBarView addSubview:titleL];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 43.6*kScreenWidthP, kScreenWidth, 0.4*kScreenWidthP)];
    lineV.backgroundColor = RGBA(34, 34, 34, 0.6);
    [navigationBarView addSubview:lineV];
}
- (void)initUI{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(15*kScreenWidthP, 64, kScreenWidth - 30*kScreenWidthP, self.view.frame.size.height)];
    NSString *Content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserAgreement" ofType:@"txt"] encoding:NSUTF8StringEncoding error: nil];
    textView.text = Content;
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    textView.textAlignment = kCTTextAlignmentJustified;
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    
}
- (void)userAgreeLeftItem:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
