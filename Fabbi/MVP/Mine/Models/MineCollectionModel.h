//
//  MineCollectionModel.h
//  Fabbi
//
//  Created by zou145688 on 16/6/16.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCollectionModel : NSObject<NSCoding>
@property (nonatomic, strong)NSString *createTime;
@property (nonatomic, assign)NSInteger hobbyType;
@property (nonatomic, assign)NSInteger pointId;
@property (nonatomic, assign)NSInteger contentId;
@property (nonatomic, strong)NSString *itemFileUrl;
@property (nonatomic, strong)NSString *specialLogoUrl;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, strong)NSString *userTel;
@property (nonatomic, strong)NSString *specialName;
@property (nonatomic, strong)NSString *itemName;
@end
