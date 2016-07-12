//
//  AppDelegate.m
//  MVP
//  Created by 刘志刚 on 16/4/18.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "AppDelegate.h"
#import "FirstPageViewController.h"
#import "Regist&LoginVC.h"
#import "GoodsViewController.h"
#import "GoodImageView.h"
#import "ViewController.h"
#import "MineViewController.h"
#import <WeiboSDK/WeiboSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <AFNetworking/AFNetworking.h>
#import "LoginViewController.h"
#import "WXApiManager.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()<WeiboSDKDelegate>
@property (nonatomic, strong) NSString *code;
@end

@implementation AppDelegate
@synthesize WBtoken;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [Bugly startWithAppId:KBUGAPPID];
    [WXApi registerApp:kWeiXinAppId];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:KWeiBoAppkey];
    id message = [[TencentOAuth alloc] initWithAppId:KQQAPPID andDelegate:nil];
    NSLog(@"%@",message);
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = KYMAppkey;
    UMConfigInstance.secret = @"secretstringfabbi";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
    // 发送通知
    NSLog(@"moblick");
    NSString *uid = [NSString stringWithFormat:@"%@",UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID)];
    if (uid) {
        [MobClick profileSignInWithPUID:uid];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self firstApp];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(createFirstPageVctrl) name:@"createFirstPageVctrl" object:nil];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)firstApp{
    
    NSString *frist = UserDefaultObjectForKey(@"first_start");
    NSLog(@"frist======%@",frist);
    if ([frist isEqualToString:@"fabbi_first_start"]) {
        [self createFirstPageVctrl];
    }else{
        UserDefaultSetObjectForKey(@"fabbi_first_start", @"first_start");
        self.window.rootViewController = [ViewController new];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        
    }
}

- (void)createFirstPageVctrl{
    UINavigationController *navCtrl =[[UINavigationController alloc]initWithRootViewController:[[FirstPageViewController alloc]init]];
    self.window.rootViewController = navCtrl;
    // 改变导航栏上的返回箭头的颜色
    [[UINavigationBar appearance]setTintColor:RGBA(83, 83, 83, 1)];
}

//  重写AppDelegate的handleOpenURL和openURL方法：
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL isSuc;
    if ([url.absoluteString hasPrefix:@"wx"]) {
        isSuc = [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if ([url.absoluteString hasPrefix:@"wb"]){
        isSuc = [WeiboSDK handleOpenURL:url delegate:self];
    }else if([url.absoluteString hasPrefix:@"QQ"]){
        isSuc = [TencentOAuth HandleOpenURL:url];
        
    }else{
        isSuc = NO;
    }
    return isSuc;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    NSString *urlstr = url.absoluteString;
    NSString *str1 =  [urlstr componentsSeparatedByString:@"&"][0];
    _code =  [str1 componentsSeparatedByString:@"="][1];
    [[NSUserDefaults standardUserDefaults]setObject:_code forKey:@"myCode"];
    // nsurl转变为字符串
    BOOL isSuc;
    if ([url.absoluteString hasPrefix:@"wx"]) {
        isSuc = [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if ([url.absoluteString hasPrefix:@"wb"]){
        isSuc = [WeiboSDK handleOpenURL:url delegate:self];
    }else if([url.absoluteString hasPrefix:@"QQ"]){
        isSuc = [TencentOAuth HandleOpenURL:url];
        
    }else{
        isSuc = NO;
    }
    return isSuc;
    
}


////第二步：授权后回调 WXApiDelegate，但是呢，没有设置协议；
//- (void)onResp:(BaseResp *)resp{
//    /*
//     ErrCode ERR_OK = 0(用户同意)
//     ERR_AUTH_DENIED = -4（用户拒绝授权）
//     ERR_USER_CANCEL = -2（用户取消）
//     code    用户换取access_token的code，仅在ErrCode为0时有效
//     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
//     lang    微信客户端当前语言
//     country 微信用户当前国家信息
//     */
//
//    // 向微信请求授权后,得到响应结果
//    if ([resp isKindOfClass:[SendAuthResp class]]) {
//        SendAuthResp *temp = (SendAuthResp *)resp;
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//        NSString *accessUrlStr = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, kWeiXinAppId, kWeiXinAppSecret, temp.code];
//        [manager GET:accessUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"请求access的response = %@", responseObject);
//            NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:responseObject];
//            NSString *accessToken = [accessDict objectForKey:kWeiXinAccessToken];
//            NSString *openID = [accessDict objectForKey:kWeiXinOpenId];
//            NSString *refreshToken = [accessDict objectForKey:kWeiXinRefreshToken];
//            // 本地持久化，以便access_token的使用、刷新或者持续
//            if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
//                [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kWeiXinAccessToken];
//                [[NSUserDefaults standardUserDefaults] setObject:openID forKey:kWeiXinAppId];
//                [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:kWeiXinRefreshToken];
//                [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
//            }
//            [self wechatLoginByRequestForUserInfo:^(NSDictionary *task, NSError *error) {
//
//            }];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"获取access_token时出错 = %@", error);
//        }];
//    }
//}
//
//- (void)wechatLoginByRequestForUserInfo:(userinfo)block {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiXinAccessToken];
//    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiXinAppId];
//    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
//    // 请求用户数据
//    [manager GET:userUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"请求用户信息的response = %@", responseObject);
//         NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
//        block(userDict,nil);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"获取用户信息时出错 = %@", error);
//    }];
//}
////第三步：使用AccessToken获取用户信息
//-(void)getUserInfo{
//
//    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
//    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
//    NSString *access_token = [usr objectForKey:@"access_token"];
//    //通过usr的NSUserDefaults
//    NSString *openId = [usr objectForKey:@"openId"];
//
//    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openId];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *zoneUrl = [NSURL URLWithString:url];
//
//        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//
//        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data) {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//                /*
//                 city = Minhang;
//                 country = CN;
//                 headimgurl = "http://wx.qlogo.cn/mmopen/ASd0Cht0TyEHicyCW8sYczGE6B8JbeuGEdDvGH86Temt4pibzI2k1VPnENgykB6dKGo2IRib4zbA9PkLKCLrwT86v4f1s0UFYfW/0";
//                 language = "zh_CN";
//                 nickname = "\U5218\U5fd7\U521a";
//                 openid = o23OYt0th1UoUvsKrrb7RoAME2VQ;
//                 privilege =     (
//                 );
//                 province = Shanghai;
//                 sex = 1;
//                 }                 */
//
//                NSString *name = [dic objectForKey:@"nickname"];
//                NSLog(@"nickname=============================%@",name) ;
//                NSLog(@"headimgurl===========================%@",[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]]);
//                NSLog(@"openId===============%@",openId);
//
//                // 通过usr的NSUserDefaults单例，把照片的字符串传递出去
//                NSString *imageStr = [dic objectForKey:@"headimgurl"];
//
//                NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
//                [usr setObject:imageStr forKey:@"zhigangImage"];
//
//                [usr setObject: name forKey:@"wechatName"];
//                [usr synchronize];
//                // 修改登录态
//                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"state"];
//
//            }
//        });
//
//    });
//}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        
        if ((NSInteger)response.statusCode == 0) {
            NSLog(@"发送请求");
            if (accessToken) {
                self.WBtoken = accessToken;
            }
            NSString *userID = [sendMessageToWeiboResponse.authResponse userID];
            if (userID) {
                
            }
            [alert show];
        }
    }else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess &&[(WBAuthorizeResponse *)response accessToken]) {
            NSDictionary *userInfo = response.userInfo;
            self.WBtoken = [(WBAuthorizeResponse *)response accessToken];
            
            NSLog(@"userInfo=%@,WBtoken=%@",userInfo,self.WBtoken);
        }
    }else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
    {
        NSString *title = NSLocalizedString(@"邀请结果", nil);
        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}
@end
