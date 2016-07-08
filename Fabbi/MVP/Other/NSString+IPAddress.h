//
//  NSString+IPAddress.h
//  Fabbi
//
//  Created by zou145688 on 16/6/15.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IPAddress)
#pragma 获取公网ip
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
#pragma 获取UUID
+(NSString *)getUniqueStrByUUID;
#pragma 获取设备id
+ (NSString *)getDeviceId;
#pragma 判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;
@end
