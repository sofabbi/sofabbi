//
//  UserStore.m
//  Fabbi
//
//  Created by zou145688 on 16/6/14.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "UserStore.h"
#import <AFNetworking.h>
#import "MyUtils.h"
//单例类的静态实例对象，因对象需要唯一性，故只能是static类型
 static UserStore *defaultManager = nil;
@implementation UserStore
+(UserStore*)defaultManager
 {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
      if(defaultManager == nil)
        {
          defaultManager = [[self alloc] init];
        }
        });
    return defaultManager;
  }
+ (void)GETWithParams:(NSDictionary *)params success:(sucess)success failure:(failure)failure{
    
    NSArray *keys = [params allKeys];
   
    NSMutableArray *strArr = [NSMutableArray array];
    for (NSString *key in keys) {
       NSString *str = [NSString stringWithFormat:@"%@=%@",key,[params objectForKey:key]];
        [strArr addObject:str];
    }
    NSString *urlStr = [strArr componentsJoinedByString:@"&"];
    //拼接URL651766ff1f7d4357bc5b3091a976d155
    NSMutableString *ticketStr = [NSMutableString stringWithFormat:@"%@%@",API_BI,urlStr];
    //1)创建AFHTTPRequestOperationManager对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2)设置返回值为二进制类型
    [manager GET:ticketStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];


}
+ (void)POSTWithParams:(NSDictionary *)params URL:(NSString *)URL success:(sucess)success failure:(failure)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@",API_development,URL];
    [manager POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}
@end
