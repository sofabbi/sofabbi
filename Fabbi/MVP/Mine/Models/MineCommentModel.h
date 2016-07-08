//
//  MineCommentModel.h
//  Fabbi
//
//  Created by zou145688 on 16/6/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCommentModel : NSObject
@property (nonatomic,strong)NSString *commentId;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *commentContens;
@property (nonatomic,strong)NSString *commentType;
@property (nonatomic,strong)NSString *commentStatus;
@property (nonatomic,strong)NSString *userTel;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *createTimeStr;
@property (nonatomic,strong)NSString *itemName;
@property (nonatomic,strong)NSString *specialName;
@property (nonatomic,assign)NSInteger specialId;
@property (nonatomic,assign)NSInteger itemId;
@property (nonatomic,assign)NSInteger pointId;
@end
