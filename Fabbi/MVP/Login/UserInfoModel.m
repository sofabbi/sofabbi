//
//  UserInfoModel.m
//  Fabbi
//
//  Created by zou145688 on 16/6/14.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "UserInfoModel.h"
#import <MJExtension/MJExtension.h>
@implementation UserInfoModel
@synthesize bindWebchart,lid,loginId,loginName,resultCode,resultMessage,userGagDate,userGagReason,userId,userName,userPassword,userRealName,userRegTime,userSalt,userStatus,userTel,userLogo;
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"lid":@"id"
             };
}
// 什么时候调用:只要一个自定义对象归档的时候就会调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.bindWebchart forKey:@"bindWebchart"];
    [aCoder encodeObject:self.lid forKey:@"lid"];
    [aCoder encodeObject:self.loginId forKey:@"loginId"];
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
    [aCoder encodeObject:self.userGagDate forKey:@"userGagDate"];
    [aCoder encodeObject:self.userGagReason forKey:@"userGagReason"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    
    [aCoder encodeObject:self.userPassword forKey:@"userPassword"];
    [aCoder encodeObject:self.userRealName forKey:@"userRealName"];
    
    [aCoder encodeObject:self.userRegTime forKey:@"userRegTime"];
    [aCoder encodeObject:self.userSalt forKey:@"userSalt"];
    
    [aCoder encodeObject:self.userStatus forKey:@"userStatus"];
    [aCoder encodeObject:self.userTel forKey:@"userTel"];
    [aCoder encodeObject:self.userLogo forKey:@"userLogo"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.bindWebchart = [aDecoder decodeObjectForKey:@"bindWebchart"];
        self.lid = [aDecoder decodeObjectForKey:@"lid"];
        self.loginId = [aDecoder decodeObjectForKey:@"loginId"];
        self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
        
        self.userGagDate = [aDecoder decodeObjectForKey:@"userGagDate"];
        self.userGagReason = [aDecoder decodeObjectForKey:@"userGagReason"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userPassword = [aDecoder decodeObjectForKey:@"userPassword"];
        
        self.userRealName = [aDecoder decodeObjectForKey:@"userRealName"];
        self.userRegTime = [aDecoder decodeObjectForKey:@"userRegTime"];
        self.userSalt = [aDecoder decodeObjectForKey:@"userSalt"];
        self.userStatus = [aDecoder decodeObjectForKey:@"userStatus"];
        self.userTel = [aDecoder decodeObjectForKey:@"userTel"];
        self.userId = [aDecoder decodeIntForKey:@"userId"];
        self.userLogo = [aDecoder decodeObjectForKey:@"userLogo"];
    }
    return self;
}
+ (void)savePerson:(UserInfoModel *)model {
    // 归档:plist存储不能存储自定义对象，此时可以使用归档来完成
    
    
    // 获取tmp目录路径
    NSString *tempPath = NSTemporaryDirectory();
    
    // 拼接文件名
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"person.data"];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}
+ (UserInfoModel *)readPerson {
    // 获取tmp
    NSString *tempPath = NSTemporaryDirectory();
    
    // 拼接文件名
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"person.data"];
    
    // 解档
    UserInfoModel *p = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return p;
}
@end
