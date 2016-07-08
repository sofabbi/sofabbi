//
//  VerifyRegexTool.h
//  完美
//
//  Created by zou145688 on 16/4/22.
//  Copyright © 2016年 zou145688. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyRegexTool : NSObject
#pragma 正则匹配手机号

+ (BOOL)checkTelNumber:(NSString *) telNumber;
+ (BOOL)validatePhone:(NSString *)phone;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 验证身份证
+ (BOOL)verifyIDCardNumber:(NSString *)value;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

@end
