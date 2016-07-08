
//  FirstPageViewController.m
//  MVP
//  Created by 刘志刚 on 16/4/18.
//  Copyright © 2016年 刘志刚. All rights reserved.

#import "FirstPageViewController.h"
#import "MineViewController.h"
#import "FirstPageSpecialCell.h"
#import "FirstPageModel.h"
#import "NetWorkRequestManager.h"
#import "MyUtils.h"
#import "AFNetworkReachabilityManager.h"
#import "LFTool.h"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
#import "DetailPageViewController.h"
#import "GoodsViewController.h"
#import "LoginViewController.h"
#import "UserStore.h"
#import "NSDate+Time.h"
#import <MJExtension/MJExtension.h>
#import <CoreLocation/CoreLocation.h>
#import "NSString+IPAddress.h"
#import <MJRefresh/MJRefresh.h>

@interface FirstPageViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
   
    BOOL  _isNetWork; // 是否有网络
}
@property (nonatomic,strong) UITableView *firstPageTbView;
@property (nonatomic,strong) NSMutableArray *firstPageArray;
@property (nonatomic, strong) CLLocationManager *localManager;
@property (nonatomic,strong)UILabel *netWorkL;
@end

@implementation FirstPageViewController
- (void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"首页"];
    self.navigationController.navigationBar.hidden = NO;
    CFTimeInterval startTime=[[NSDate new] timeIntervalSince1970];
    _loadNewdataTime = startTime;
    
   [self checkNetWork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstPageArray = [NSMutableArray array];
    
    UIImageView *titleView = [MyUtils createImageViewFrame:CGRectMake(161*kScreenWidthP, 27*kScreenWidthP, 51.1*kScreenWidthP, 29.9*kScreenWidthP) imageName:@"firstpage_logo"];
    self.navigationItem.titleView = titleView;
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self addNavigationButtonWithFrame:CGRectMake(0, 16*kScreenWidthP, 20*kScreenWidthP, 12*kScreenWidthP) title:nil titleColor:nil isLeft:YES imageName:@"icon-menu " selectedImageName:@"icon-menu" backgroundColor:[UIColor clearColor] target:self action:@selector(toMineVctrl:)];
    
    [self createTbView];
    
    [self getLocation];

}

#pragma 导航栏左右
- (void)navigationItemlr{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0.f, -25.f, 0.f, 25.f)];
    }else{
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0.f, -12.f, 0.f, 12.f)];
    }
    
    [backButton setImage:[UIImage imageNamed:@"icon-menu"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon-menu"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(toMineVctrl:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
}
/**
  当没有登陆时，到登陆页面
 */
- (void)toMineVctrl:(UIButton *)btn{
   NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
   
    if (uid) {
        MineViewController *mineVctrl = [[MineViewController alloc]init];
        [self.navigationController pushViewController:mineVctrl animated:YES];
    }else{
        LoginViewController *loginVctrl = [[LoginViewController alloc]init];
        loginVctrl.isFirstPage = @"FirstPageViewController";
        [self.navigationController pushViewController:loginVctrl animated:YES];
     }
}

/**
 基础接口获取接口票据
 
 */
- (void)loadNewData{
    [MobClick event:@"HomePageDownRefresh"];
    self.firstPageTbView.mj_footer.hidden = NO;
    if (_firstPageArray.count > 0) {
        [_firstPageArray removeAllObjects];
    }
    
    NSString *time = [NSDate timeStamp:_loadNewdataTime];
    _moreStartTime = _loadNewdataTime;
  
            NSDictionary *dic = @{
                                  @"dateTime":time
                                  };
            [UserStore POSTWithParams:dic URL:@"api/queryItemAndSpecialList.html" success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSArray *arr = (NSArray *)responseObject;
                if (arr.count>0) {
                    NSMutableArray *array = [NSMutableArray array];
                    for (NSDictionary *dic in arr) {
                        FirstPageModel *model = [[FirstPageModel alloc]init];
                        model.goodsType = [dic objectForKey:@"goodsType"];
                        model.resultCode = [dic objectForKey:@"resultCode"];
                        model.createTime = [dic objectForKey:@"createTime"];
                        model.resultMessage = [dic objectForKey:@"resultMessage"];
                        model.firstItemVoModel = [dic objectForKey:@"itemVo"];
                        model.firstSpecialVoModel = [dic objectForKey:@"specialVo"];

                        if ([model.goodsType isEqualToNumber:[NSNumber numberWithDouble:1]]) {
                            NSNumber *isShow = [model.firstItemVoModel objectForKey:@"itemIsShow"];
                            
                            if (((NSNull *)isShow == [NSNull null])) {
                                continue;

                            }
                           
                        }
                        [array addObject:model];
                    }
                    
                    if (array.count > 0) {
                        NSMutableArray *ReverseArr = [NSMutableArray array];
                        [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [ReverseArr addObject:obj];
                        }];
                        [_firstPageArray addObject:ReverseArr];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_firstPageTbView reloadData];
                            [_firstPageTbView.mj_header endRefreshing];
                        });
                        return ;
                    }else{
                        [self loadnewD];
                    }
                }else{
                    [self loadnewD];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
    
}

#pragma 递归
- (void)loadnewD{
    _loadNewdataTime = _loadNewdataTime - 60*60*24;
    // 最早数据到2016-6-25号为:1466824861
    if (_loadNewdataTime < 1463673601) {
        return;
    }else{
        [self loadNewData];
    }
}
#pragma 更多
- (void)loadMoreData{
    [MobClick event:@"HomePageUpRefresh"];
    _moreStartTime = _moreStartTime - 60*60*24;
    NSString *time = [NSDate timeStamp:_moreStartTime];
    
    NSDictionary *dic = @{
                          @"dateTime":time
                          };
    
    [UserStore POSTWithParams:dic URL:@"api/queryItemAndSpecialList.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = (NSArray *)responseObject;
        if (arr.count>0) {
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                FirstPageModel *model = [[FirstPageModel alloc]init];
                model.goodsType = [dic objectForKey:@"goodsType"];
                model.resultCode = [dic objectForKey:@"resultCode"];
                model.createTime = [dic objectForKey:@"createTime"];
                model.resultMessage = [dic objectForKey:@"resultMessage"];
                model.firstItemVoModel = [dic objectForKey:@"itemVo"];
                model.firstSpecialVoModel = [dic objectForKey:@"specialVo"];
                if ([model.goodsType isEqualToNumber:[NSNumber numberWithDouble:1]]) {
                    NSNumber *isShow = [model.firstItemVoModel objectForKey:@"itemIsShow"];
                    if (((NSNull *)isShow == [NSNull null])) {
                        continue;
                    }
                }
                [array addObject:model];
            }
            NSMutableArray *ReverseArr = [NSMutableArray array];
            [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ReverseArr addObject:obj];
            }];
            [_firstPageArray addObject:ReverseArr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_firstPageTbView reloadData];
                [_firstPageTbView.mj_footer endRefreshing];
            });
            return ;
        }else{
//            最早数据到2016-6-25号为:1466824861
            if (_moreStartTime < 1466824861) {
                [self.firstPageTbView.mj_footer endRefreshingWithNoMoreData];
                self.firstPageTbView.mj_footer.hidden = YES;
                return;
            }else{
               [self loadMoreData];
            }
           
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}




/**
 创建tableview
 */
- (void)createTbView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.firstPageTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    self.firstPageTbView.delegate = self;
    self.firstPageTbView.dataSource = self;
    _firstPageTbView.separatorStyle = NO;
    
    [self.view addSubview:self.firstPageTbView];
    [self createRefresh];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBA(239, 239, 239, 1);
    
    UILabel *labelA = [MyUtils createLabelFrame:CGRectMake(20*kScreenWidthP, 20*kScreenWidthP, 120*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(186, 186, 186, 1) title:nil font:0.f];
    [view addSubview:labelA];
    
    UILabel *labelB = [MyUtils createLabelFrame:CGRectMake(235*kScreenWidthP, 20*kScreenWidthP, 120*kScreenWidthP, 0.5*kScreenWidthP) backgroundColor:RGBA(186, 186, 186, 1) title:nil font:0.f];
    [view addSubview:labelB];
  
    UILabel *labelC = [MyUtils createLabelFrame:CGRectMake(kScreenWidth/2 - 40*kScreenWidthP, 4*kScreenWidthP, 80*kScreenWidthP, 32*kScreenWidthP) backgroundColor:RGBA(186, 186, 186, 0) title:@"nil" font:14*kScreenWidthP];
    labelC.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*kScreenWidthP];
    labelC.textColor = RGBA(186, 186, 186, 1);
    labelC.center = CGPointMake(kScreenWidth/2 , 20*kScreenWidthP);
    labelC.textAlignment = NSTextAlignmentCenter;
    NSArray *arr = [_firstPageArray objectAtIndex:section];
    if (arr.count > 0) {
        NSString *timeStr;
        FirstPageModel *model = [arr firstObject];
        if ([model.goodsType isEqualToNumber:[NSNumber numberWithDouble:1]]) {
            timeStr = [model.firstItemVoModel objectForKey:@"itemCreateTimeStr"];
            
        }else{
            timeStr = [model.firstSpecialVoModel objectForKey:@"specialCreateTimeStr"];
            
        }
        NSLog(@"times========%@",timeStr);
      NSString *time = [NSDate firstTimeStr:timeStr];
        labelC.text = time;
    }
    
    [view addSubview:labelC];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40*kScreenWidthP;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 最后一个，高度要减少10*kscreenWidthP;
    NSArray *arr = [_firstPageArray objectAtIndex:indexPath.section];
    if (indexPath.row == (arr.count -1)) {
        return 305*kScreenWidthP;
    }else{
         return 315*kScreenWidthP;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _firstPageArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [_firstPageArray objectAtIndex:section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *firstPageSpecialCellId = @"firstPageSpecialCellId";
    FirstPageSpecialCell *firstPageSpecialCell = [tableView dequeueReusableCellWithIdentifier:firstPageSpecialCellId];
    
    if (firstPageSpecialCell == nil) {
        firstPageSpecialCell= [[FirstPageSpecialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        firstPageSpecialCell.backgroundColor = RGBA(239, 239, 239, 1);
        firstPageSpecialCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableArray *array = self.firstPageArray [indexPath.section];
    FirstPageModel *model = array[indexPath.row];
    [firstPageSpecialCell configfirstPageModel:model];
    return firstPageSpecialCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_firstPageArray.count > 0) {
        NSMutableArray *array = self.firstPageArray [indexPath.section];
        FirstPageModel *model = array[indexPath.row];
        NSString *googType =[NSString stringWithFormat:@"%@",model.goodsType];
        if ([googType isEqualToString:@"1"]) {
            DetailPageViewController *detailVctrl = [[DetailPageViewController alloc]init];
            detailVctrl.itemId = [model.firstItemVoModel objectForKey:@"id"];
            
            self.navigationController.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:detailVctrl animated:YES];
        }else if ([googType isEqualToString:@"2"]){
            GoodsViewController *goodsVctrl = [[GoodsViewController alloc]init];
            goodsVctrl.speicalId = [model.firstSpecialVoModel objectForKey:@"id"];
            [self.navigationController pushViewController:goodsVctrl animated:YES];
        }
        
  
    }
   }


#pragma mark 创建刷新视图
- (void)createRefresh {
    //设置回调（一旦你进入刷新状态，然后调用对象的动作，也就是调用[个体经营loadNewData]）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.automaticallyChangeAlpha = YES;
    self.firstPageTbView.mj_header = header;
    
    //输入刷新状态立即
    [_firstPageTbView.mj_header beginRefreshing];
   
   MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    _firstPageTbView.mj_footer = footer;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
}

#pragma mark 检测有无网络
- (void)checkNetWork{
    // 初始化网络检测者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    // 开启检测
    [manger startMonitoring];
    // 检测之后通过block返回值
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                _isNetWork = NO;
                [LFTool setBool:_isNetWork forKey:LFIsNetWork];
                _firstPageTbView.hidden = YES;
                [self.view addSubview:self.netWorkL];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _isNetWork = YES;
                [LFTool setBool:_isNetWork forKey:LFIsNetWork];
                _firstPageTbView.hidden = NO;
                [self.netWorkL removeFromSuperview];
//                [self loadNewData];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _isNetWork  = YES;
                [LFTool setBool:_isNetWork forKey:LFIsNetWork];
           _firstPageTbView.hidden = NO;
                _netWorkL.hidden = YES;
//                [self loadNewData];
                [self.netWorkL removeFromSuperview];
                break;
            case AFNetworkReachabilityStatusUnknown:
                _firstPageTbView.hidden = NO;
                _netWorkL.hidden = YES;
                _isNetWork = YES;
                [LFTool setBool:_isNetWork forKey:LFIsNetWork];
                [self.netWorkL removeFromSuperview];
//                [self loadNewData];
                break;
            default:
                break;
        }
    }];
}
#pragma mark - 获取地理位置
- (void)getLocation{
    _localManager = [[CLLocationManager alloc]init];
    _localManager.delegate = self;
    _localManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    _localManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self triggerLocationServices];
    }
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorized) {
        [self startUpdatingLocation];
    }
}

- (void)triggerLocationServices{
    if ([CLLocationManager locationServicesEnabled]) {
        if ([_localManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_localManager requestWhenInUseAuthorization];
        }else{
            [self startUpdatingLocation];
        }
    }
}

- (void)startUpdatingLocation{
    [_localManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [_localManager stopUpdatingLocation];
   NSString *ipv4 = [NSString getIPAddress:YES];
    NSString *uuid = [NSString getDeviceId];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    NSString *location = [NSString stringWithFormat:@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (ipv4) {
        [dic setObject:ipv4 forKey:@"eventContent2"];
    }
    if (uuid) {
        [dic setObject:uuid forKey:@"uuid"];
    }
    if (location) {
        [dic setObject:location forKey:@"eventContent1"];
    }
    
    [dic setObject:@"17" forKey:@"eventID"];
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    if (uid) {
        [dic setObject:uid forKey:@"uid"];
    }
   
    [UserStore GETWithParams:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"首页"];
}

#pragma 无网络时
- (UILabel *)netWorkL{
    if (_netWorkL==nil) {
        _netWorkL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30*kScreenWidthP)];
        _netWorkL.textAlignment = NSTextAlignmentCenter;
        _netWorkL.text = @"哎呀,好像没有信号哦!";
        _netWorkL.center = CGPointMake(kScreenWidth/2, kScreenHeight*2/5);
        _netWorkL.tag = 10001;
    }
    return _netWorkL;
}

@end
