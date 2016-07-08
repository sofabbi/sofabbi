//
//  MineCollectionModel.m
//  Fabbi
//
//  Created by zou145688 on 16/6/16.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MineCollectionModel.h"
#import <MJExtension/MJExtension.h>
@implementation MineCollectionModel
@synthesize createTime,hobbyType,contentId,itemFileUrl,specialLogoUrl,pointId,userId,userTel;
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"contentId":@"id"
             };
}
// 什么时候调用:只要一个自定义对象归档的时候就会调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.itemFileUrl forKey:@"itemFileUrl"];
    [aCoder encodeObject:self.specialLogoUrl forKey:@"specialLogoUrl"];
    [aCoder encodeObject:self.userTel forKey:@"userTel"];
   
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeInteger:self.hobbyType forKey:@"hobbyType"];
    [aCoder encodeInteger:self.contentId forKey:@"contentId"];
    [aCoder encodeInteger:self.pointId forKey:@"pointId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.itemFileUrl = [aDecoder decodeObjectForKey:@"itemFileUrl"];
        self.specialLogoUrl = [aDecoder decodeObjectForKey:@"specialLogoUrl"];
        self.userTel = [aDecoder decodeObjectForKey:@"userTel"];
        
        self.userId = [aDecoder decodeIntForKey:@"userId"];
        self.hobbyType = [aDecoder decodeIntForKey:@"hobbyType"];
        self.contentId = [aDecoder decodeIntForKey:@"contentId"];
        self.pointId = [aDecoder decodeIntForKey:@"pointId"];
        
    }
    return self;
}
@end
