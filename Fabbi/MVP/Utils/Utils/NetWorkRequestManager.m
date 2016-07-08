//
//  NetWorkRequestManager.m
//  EATFIT
//
//  Created by 刘志刚 on 16/4/5.
//  Copyright © 2016年 刘志刚. All rights reserved.
//
#import "MyUtils.h"

#import "NetWorkRequestManager.h"
#import <AFNetworking.h>
//void(^block1)(void);
//void(^block2)(NSString *str);
//NSString*(^blcok3)(NSString *str);

@implementation NetWorkRequestManager
+ (void)GETWithParams:(NSMutableArray *)params URL:(NSString *)URL success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableArray *array = params;
    // 排序
    [array sortUsingSelector:@selector(compare:)];
    // 排序好的，用空的signature字符串进行追加
    NSMutableString *signature = [NSMutableString string];
    for (NSMutableString *str in array) {
        [signature appendString:str];
    }

    // 获取加密后的签名signMD5
    NSString *signMD5 = [MyUtils md5:[NSString stringWithFormat:@"%@%@",[MyUtils md5:signature],SECRET]];
    NSString *signStr = [NSString stringWithFormat:@"sign=%@",signMD5];
    // 获取链接
    //拼接URL
    NSMutableString *ticketStr = [NSMutableString stringWithFormat:@"%@",URL];
    for (NSString *str in params) {
        [ticketStr appendFormat:@"%@&",str];
    }
    [ticketStr appendString:signStr];
    
    // 创建请求管理
    
    //1)创建AFHTTPRequestOperationManager对象
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //2)设置返回值为二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:ticketStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)POSTWithParams:(NSMutableArray *)params URL:(NSString *)URL success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableArray *array = params;
    // 排序
    [array sortUsingSelector:@selector(compare:)];
    // 排序好的，用空的signature字符串进行追加
    NSMutableString *signature = [NSMutableString string];
    for (NSMutableString *str in array) {
        [signature appendString:str];
    }
    
    // 获取加密后的签名signMD5
    NSString *signMD5 = [MyUtils md5:[NSString stringWithFormat:@"%@%@",[MyUtils md5:signature],SECRET]];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i<params.count; i++) {
        NSString *str = params[i];
        NSArray *stttt = [str componentsSeparatedByString:@"="];
        [dict setObject:stttt[1] forKey:stttt[0]];
    }
    [dict setObject:signMD5 forKey:@"sign"];
    NSLog(@"dict=%@",dict);
    //1)创建AFHTTPRequestOperationManager对象
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //2)设置返回值为二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

   [manager POST:URL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
       if (success) {
           success(responseObject);
       }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       if (failure) {
           failure(error);
       }
   }];
    
}
@end
