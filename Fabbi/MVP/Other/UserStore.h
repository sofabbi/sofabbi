//
//  UserStore.h
//  Fabbi
//
//  Created by zou145688 on 16/6/14.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^sucess)(NSURLSessionDataTask *task, id responseObject);
typedef void (^failure)(NSURLSessionDataTask *task, NSError *error);
@interface UserStore : NSObject
+(UserStore*)defaultManager;
+ (void)POSTWithParams:(NSDictionary *)params URL:(NSString *)URL success:(sucess)success failure:(failure)failure;
+ (void)GETWithParams:(NSDictionary *)params  success:(sucess)success failure:(failure)failure;
@end
