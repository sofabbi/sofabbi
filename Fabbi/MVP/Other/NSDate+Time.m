//
//  NSDate+Time.m
//  Fabbi
//
//  Created by zou145688 on 16/6/14.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)
+(NSDate *)getCurrentDate{
    //    1.通过date方法创建出来的对象,就是当前时间对象;
    NSDate *date = [NSDate date];
    return date;
}
+(NSTimeZone *)getCurrentZone{
    //   2.获取当前所处时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    return zone;
}
+(NSString*)getTime:(NSString *)type{

    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = type;
    NSString *res = [formatter stringFromDate:date];
    return res;
}
//时间戳转时间
+(NSString *)timeStamp:(CFTimeInterval)timeStamp{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datea = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *dateString = [formatter stringFromDate:datea];
    return dateString;
}
//时间转时间戳
+(CFTimeInterval)TimeInterval:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    CFTimeInterval timeSp = [date timeIntervalSince1970];
    return timeSp;
}
//首页section时间
+(NSString *)firstTimeStr:(NSString *)timeStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
     CFTimeInterval timeSp = [date timeIntervalSince1970];
    CFTimeInterval releaseTime = [NSDate firstTime:timeSp];
    
    NSDate *datenow = [NSDate date];
     CFTimeInterval dateNow = [datenow timeIntervalSince1970];
    CFTimeInterval nowTime = [NSDate firstTime:dateNow];
    CFTimeInterval timeDifference = nowTime - releaseTime;
    NSString *dateString;
    //天数相减86400
    if (timeDifference<86400&&timeDifference >=0) {
        dateString = @"今天";
    }else if(timeDifference < 86400*2&&timeDifference>=86400){
        dateString = @"昨天";
    }else if (timeDifference < 86400*3&&timeDifference>=86400*2){
        dateString = @"前天";
    }else{
        dateString = [NSDate firstTimeStamp:releaseTime];
    }
    return dateString;
}
+(CFTimeInterval)firstTime:(CFTimeInterval)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datea = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *dateString = [formatter stringFromDate:datea];
    CFTimeInterval firstTime = [NSDate firstTimeInterval:dateString];
    return firstTime;
}

+(CFTimeInterval)firstTimeInterval:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [formatter dateFromString:timeStr];
    CFTimeInterval timeSp = [date timeIntervalSince1970];
    return timeSp;
}
+(NSString *)firstTimeStamp:(CFTimeInterval)timeStamp{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    NSDate *datea = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *dateString = [formatter stringFromDate:datea];
    return dateString;
}
//评论时间
+(NSString *)timtimeStr:(NSString *)timeStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    NSDate *datenow = [NSDate date];
    
    CFTimeInterval timeSp = [date timeIntervalSince1970];
    CFTimeInterval dateNow = [datenow timeIntervalSince1970];
    CFTimeInterval deltaTimeInSeconds = dateNow - timeSp;
    NSString *dateString;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:deltaTimeInSeconds];
    if (deltaTimeInSeconds < 60&&deltaTimeInSeconds>0) {
        dateString = @"刚刚";
    }else if (deltaTimeInSeconds < 60*60&&deltaTimeInSeconds > 60) {
        [formatter setDateFormat:@"m"];
        NSString *timeS = [formatter stringFromDate:confromTimesp];
        dateString = [NSString stringWithFormat:@"%@分钟前",timeS];
    }else if(deltaTimeInSeconds < 60*60*24&&deltaTimeInSeconds > 60*60){
        [formatter setDateFormat:@"H"];
        NSString *timeS = [formatter stringFromDate:confromTimesp];
        dateString = [NSString stringWithFormat:@"%@小时前",timeS];
    }else if (deltaTimeInSeconds > 60*60*24){
         [formatter setDateFormat:@"MM-dd HH:mm"];
        NSString *timeS = [formatter stringFromDate:confromTimesp];
        dateString = timeS;
    }
    
    return dateString;
}
+(NSString *)firstPageSectionTime:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    NSDate *datenow = [NSDate date];
    
    CFTimeInterval timeSp = [date timeIntervalSince1970];
    CFTimeInterval dateNow = [datenow timeIntervalSince1970];
    CFTimeInterval deltaTimeInSeconds = dateNow - timeSp;
    NSString *dateString;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:deltaTimeInSeconds];
    if (deltaTimeInSeconds < 60&&deltaTimeInSeconds>0) {
        dateString = @"刚刚";
    }else if (deltaTimeInSeconds < 60*60&&deltaTimeInSeconds > 60) {
        [formatter setDateFormat:@"m"];
        NSString *timeS = [formatter stringFromDate:confromTimesp];
        dateString = [NSString stringWithFormat:@"%@分钟前",timeS];
    }else if(deltaTimeInSeconds < 60*60*24&&deltaTimeInSeconds > 60*60){
        [formatter setDateFormat:@"H"];
        NSString *timeS = [formatter stringFromDate:confromTimesp];
        dateString = [NSString stringWithFormat:@"%@小时前",timeS];
    }else if (deltaTimeInSeconds > 60*60*24){
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSString *timeS = [formatter stringFromDate:confromTimesp];
        dateString = timeS;
    }
    
    return dateString;
}
@end
