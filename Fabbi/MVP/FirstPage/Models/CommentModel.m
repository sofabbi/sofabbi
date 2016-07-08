//
//  CommentModel.m
//  MVP
//
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "CommentModel.h"
#import <MJExtension/MJExtension.h>
@implementation CommentModel
@synthesize commentId,userId,userName,commentContens,commentType,commentStatus,userTel,createTime,createTimeStr;
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"commentId":@"id"
            };
}
@end
