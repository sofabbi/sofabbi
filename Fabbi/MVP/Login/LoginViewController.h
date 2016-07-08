//
//  LoginViewController.h
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property (nonatomic,strong) UIImageView *loginBackImageView;
@property (nonatomic,strong) NSString *isFirstPage;
@property (nonatomic,strong) UIImageView *loginBackgroundView;
@property (nonatomic,strong) UIImageView *registBackgroundView;
@property (copy, nonatomic) void (^requestForUserInfoBlock)();
@end
