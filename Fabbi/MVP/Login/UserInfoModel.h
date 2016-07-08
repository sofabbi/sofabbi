//
//  UserInfoModel.h
//  Fabbi
//
//  Created by zou145688 on 16/6/14.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject<NSCoding>
@property (nonatomic, strong)NSString *bindWebchart;
@property (nonatomic, assign)int userId;
@property (nonatomic, strong)NSString *lid;
@property (nonatomic, strong)NSString *loginId;
@property (nonatomic, strong)NSString *loginName;

@property (nonatomic, strong)NSString *resultCode;
@property (nonatomic, strong)NSString *resultMessage;
@property (nonatomic, strong)NSString *userGagDate;
@property (nonatomic, strong)NSString *userGagReason;

@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *userPassword;

@property (nonatomic, strong)NSString *userRealName;
@property (nonatomic, strong)NSString *userRegTime;
@property (nonatomic, strong)NSString *userSalt;
@property (nonatomic, strong)NSString *userStatus;
@property (nonatomic, strong)NSString *userTel;
@property (nonatomic, strong)NSString *userLogo;

+ (void)savePerson:(UserInfoModel *)model;
+ (UserInfoModel *)readPerson;
@end
