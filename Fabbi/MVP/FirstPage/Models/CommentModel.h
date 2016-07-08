//
//  CommentModel.h
//  MVP
//
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic,strong)NSString *commentId;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *commentContens;
@property (nonatomic,strong)NSString *commentType;
@property (nonatomic,strong)NSString *commentStatus;
@property (nonatomic,strong)NSString *userTel;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *createTimeStr;
@property (nonatomic,strong)NSString *userLogo;
@end
