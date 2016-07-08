//
//  LFTool.m
//  1506_LimitFree
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//

#import "LFTool.h"
#import "SDImageCache.h"




#define LFUserDefaults [NSUserDefaults standardUserDefaults]

@implementation LFTool

+ (void)setBool:(BOOL)b forKey:(NSString *)key
{
    [LFUserDefaults setBool:b forKey:key];
    [LFUserDefaults synchronize];
}

+ (void)setObject:(id)obj forKey:(NSString *)key
{
    [LFUserDefaults setObject:obj forKey:key];
    [LFUserDefaults synchronize];
}

+ (BOOL)boolForKey:(NSString *)key
{
    return [LFUserDefaults boolForKey:key];
}

+ (id)objectForKey:(NSString *)key
{
    return [LFUserDefaults objectForKey:key];
}

#pragma mark 获取缓存
+ (NSString *)getCacheNumber
{
    NSString *cacheStr;
    // cacheSize返回的单位是B
    int cacheSize = (int)[[SDImageCache sharedImageCache] getSize];
    if (cacheSize <= 1024) {
        cacheStr = [NSString stringWithFormat:@"%i B", cacheSize];
    } else if (cacheSize > 1024 && cacheSize <= (1024 * 1024)) {
        cacheStr = [NSString stringWithFormat:@"%i KB", cacheSize / 1024];
    } else if (cacheSize > (1024 * 1024) && cacheSize <= (1024 * 1024 * 1024)) {
        cacheStr = [NSString stringWithFormat:@"%i MB", cacheSize / (1024 * 1024)];
    } else {
        cacheStr = [NSString stringWithFormat:@"%i G", cacheSize / (1024 * 1024 * 1024)];
    }
    
    return cacheStr;
}



@end
