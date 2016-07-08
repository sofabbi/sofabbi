//
//  NSDate+Time.h
//  Fabbi
//
//  Created by zou145688 on 16/6/14.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Time)
+(NSString*)getTime:(NSString *)type;
+(NSString *)timeStamp:(CFTimeInterval)timeStamp;
#pragma 评论时间
+(NSString *)timtimeStr:(NSString *)timeStr;
#pragma 时间字符串转时间戳
+(CFTimeInterval)TimeInterval:(NSString *)timeStr;
#pragma 首页section时间
+(NSString *)firstTimeStr:(NSString *)timeStr;
@end
