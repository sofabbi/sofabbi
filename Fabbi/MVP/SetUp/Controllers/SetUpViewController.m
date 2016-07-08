//
//  SetUpViewController.m
//  MVP
//
//  Created by 刘志刚 on 16/4/19.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "SetUpViewController.h"
#import "OpionbackViewController.h"
#import "UserAgreeViewController.h"
#import "AboutUsViewController.h"
#import "MyUtils.h"
#import "FirstPageViewController.h"
#import "Cuetom_alert.h"
@interface SetUpViewController ()<UITableViewDataSource,UITableViewDelegate,custom_alertViewDelegate>
@property (nonatomic,strong)UITableView *setUpTbView;
@property (nonatomic,strong)NSArray *setUpArray;
@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatNavBar];
//    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
//    navigationBar.backgroundColor = [UIColor whiteColor];
//     [self.view addSubview: navigationBar];
   self.view.backgroundColor = [UIColor whiteColor];
//    
//    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"设置"];
//    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
//    //创建UIBarButton 可根据需要选择适合自己的样式
//   UIBarButtonItem *setUpLeftItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(setUpLeftItem:)];
//    //设置barbutton
//    navigationBarTitle.leftBarButtonItem = setUpLeftItem;
//    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
    
    
//    navigationBar.backItem.leftBarButtonItem = setUpLeftItem;
    
    UIButton *exitBtn = [MyUtils createButtonFrame:CGRectMake(53*kScreenWidthP, kScreenHeight-105*kScreenWidthP, 270*kScreenWidthP, 45*kScreenWidthP) title:@"退出登录" selectTitle:@"退出登录" titleColor:RGBA(67, 181, 223, 1) bgImageName:nil selectImageName:nil backgroundColor:RGBA(0, 0, 0, 0) layerCornerRadius:22.5*kScreenWidthP target:self action:NSSelectorFromString(@"exitBtn")];
    exitBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*kScreenWidthP];
    exitBtn.layer.borderWidth = 1*kScreenWidthP;
    exitBtn.layer.borderColor = RGBA(67, 181, 223, 1).CGColor;
    exitBtn.layer.masksToBounds = YES;
    [self.view addSubview:exitBtn];
    
    
    [self createDataSource];
    [self createTbView];
    [self setExtraCellLineHidden:self.setUpTbView];
}
- (void)creatNavBar{
    UIView *navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    navigationBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationBarView];
    
    UIView *bavkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    bavkView.userInteractionEnabled = YES;
    [navigationBarView addSubview:bavkView];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setUpLeftItem:)];
    [bavkView addGestureRecognizer:backTap];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18*kScreenWidthP, 12*kScreenWidthP, 11*kScreenWidthP, 20*kScreenWidthP)];
    backImageView.image = [UIImage imageNamed:@"back"];
    backImageView.center = CGPointMake(23.5*kScreenWidthP, 22*kScreenWidthP);
    [bavkView addSubview:backImageView];
    
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 88*kScreenWidthP, 44)];
    titleL.center = CGPointMake(kScreenWidth/2, 22);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"设置";
    titleL.font = [UIFont systemFontOfSize:17*kScreenWidthP];
    [navigationBarView addSubview:titleL];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 43.6*kScreenWidthP, kScreenWidth, 0.4*kScreenWidthP)];
    lineV.backgroundColor = RGBA(34, 34, 34, 0.6);
    [navigationBarView addSubview:lineV];
}
- (void)setUpLeftItem:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
//   [self dismissViewControllerAnimated:NO completion:nil];
}

/**
 隐藏多余的分割线
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

- (void)createDataSource{
    self.setUpArray = @[@"意见反馈",@"用户协议",@"关于我们",@"清理缓存"];
}

- (void)createTbView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.setUpTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64*kScreenWidthP, kScreenWidth, kScreenHeight-64*kScreenWidthP-200*kScreenWidthP)style:UITableViewStylePlain];
    self.setUpTbView.delegate = self;
    self.setUpTbView.dataSource = self;
    self.setUpTbView.scrollEnabled = NO;
    [self.view addSubview:self.setUpTbView];
}
// 退出登录
- (void)exitBtn{
    Cuetom_alert *alert = [[Cuetom_alert alloc]initWithTitle:nil message:@"你确定要退出" delegate:self andButtons:@[@"取消",@"确定"]];
    alert.delegate = self;
    [alert show];
  
}
- (void)popAlertView:(Cuetom_alert *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UserDefaultRemoveObjectForKey(FABBI_AUTHORIZATION_UID);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark-UITabelView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*kScreenWidthP;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *setUpCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    setUpCell.selectionStyle = UITableViewCellSelectionStyleNone;
    setUpCell.textLabel.text = self.setUpArray[indexPath.row];
    setUpCell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    setUpCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return setUpCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            OpionbackViewController *opbackVctrl = [[OpionbackViewController alloc]init];
//            [self changPushType];
            [self.navigationController pushViewController:opbackVctrl animated:YES];
        }
            break;
        case 1:{
            UserAgreeViewController *userAgreeVctrl = [[UserAgreeViewController alloc]init];
//            [self changPushType];
            [self.navigationController pushViewController:userAgreeVctrl animated:YES];
        }
            break;
        case 2:{
            AboutUsViewController *aboutUsVctrl = [[AboutUsViewController alloc]init];
//            [self changPushType];
            [self.navigationController pushViewController:aboutUsVctrl animated:YES];
        }
          break;
        default:{
            UIAlertView *verifyTextFieldEmpty = [[UIAlertView alloc]initWithTitle:@"清理缓存" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [verifyTextFieldEmpty show];
        }
            break;
    }

}
- (void)changPushType{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromRight;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}
@end
