//
//  AppDelegate.h
//  MVP
//
//  Created by 刘志刚 on 16/4/18.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

typedef void (^userinfo)(NSDictionary *task, NSError *error);
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    NSString *WBtoken;
  
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *WBtoken;

- (void)wechatLoginByRequestForUserInfo:(userinfo)block;
@end

