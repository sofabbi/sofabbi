//
//  SpecialVoDetailModel.m
//  Fabbi
//
//  Created by zou145688 on 16/6/15.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "SpecialVoDetailModel.h"
#import <MJExtension/MJExtension.h>
@implementation SpecialVoDetailModel
@synthesize specialUpdateUser,specialStatus,specialCreateUser,specialName,specialid,specialEditUser,specialUpdateTime,specialSourceName,specialExamTime,specialCategoryId,specialPublishTime,specialPublishUserName,collectionSum,specialCnotensList,specialCategoryName,loginName,specialExamUserName,specialNotes,specialEditUserName,specialExamUser,specialCreateTime,specialEditTime,specialLogoUrl,extTime,loginId,specialPublishUser,specialUpdateUserName,specialCreateUserName;

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"specialid":@"id"
             };
}
@end
