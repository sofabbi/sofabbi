//
//  LFTool.h
//  1506_LimitFree
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFTool : NSObject
// 设值
+ (void)setBool:(BOOL)b forKey:(NSString *)key;
+ (void)setObject:(id)obj forKey:(NSString *)key;

// 取值u
+ (BOOL)boolForKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;


// 计算缓存
+ (NSString *)getCacheNumber;

@end
