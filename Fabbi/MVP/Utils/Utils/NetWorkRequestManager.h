//
//  NetWorkRequestManager.h
//  EATFIT
//
//  Created by 刘志刚 on 16/4/5.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkRequestManager : NSObject
/**
 get请求的封装
 */
+ (void)GETWithParams:(NSMutableArray *)params URL:(NSString *)URL  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 post请求的封装
 */
+ (void)POSTWithParams:(NSMutableArray *)params URL:(NSString *)URL  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
