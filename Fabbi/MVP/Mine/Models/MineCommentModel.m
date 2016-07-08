//
//  MineCommentModel.m
//  Fabbi
//
//  Created by zou145688 on 16/6/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MineCommentModel.h"
#import <MJExtension/MJExtension.h>
@implementation MineCommentModel
@synthesize commentId,userId,userName,commentContens,commentType,commentStatus,userTel,createTime,itemName,specialName,createTimeStr;
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"commentId":@"id"
             };
}
@end
