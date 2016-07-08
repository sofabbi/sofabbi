//
//  FirstPageModel.m
//  MVP
//
//  Created by 刘志刚 on 16/4/22.
//  Copyright © 2016年 刘志刚. All rights reserved.
//




#import "FirstPageModel.h"
#import <MJExtension/MJExtension.h>
//@implementation FirstItemVoModel
//@synthesize brandNotes,categoryLevalOne,categoryLevalTwo,categoryLevalThree,categoryOneName,categoryTwoName,categoryThreeName,extTime,itemvoid,itemBrandId,itemCategoryId,itemContens,itemCreateTime,itemCreateUser,itemCreateUserName,itemEditTime,itemEditUser,itemEditUserName,itemExamTime,itemExamUser,itemExamUserName,itemFileList,itemName,itemNotes,itemPrice,itemPublishTime,itemPublishUser,itemPublishUserName,itemSourceName,itemSourceUrl,itemStatus,itemUpdateTime,itemUpdateUser,itemUpdateUserName,loginId,loginName,loveSum,resultCode,resultMessage;
//
//+(NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{@"itemvoid":@"id"
//             };
//}
//@end
//
//
//@implementation FirstSpecialVoModel
//@synthesize specialUpdateUser,specialStatus,specialCreateUser,specialName,specialid,specialEditUser,specialUpdateTime,specialSourceName,specialExamTime,specialCategoryId,specialPublishTime,specialPublishUserName,collectionSum,specialCnotensList,specialCategoryName,loginName,specialExamUserName,specialNotes,specialEditUserName,specialExamUser,specialCreateTime,specialEditTime,specialLogoUrl,extTime,loginId,specialPublishUser,specialUpdateUserName,specialCreateUserName;
//
//+(NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{@"specialid":@"id"
//             };
//}
//@end
@implementation FirstPageModel


- (instancetype)init{
    self = [super init];
    if (self) {
        self.firstSpecialVoModel = [NSDictionary dictionary];
        self.firstItemVoModel = [NSDictionary dictionary];
        
    }return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return @"";
}


//NSURL *url1 = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/d01373f082025aaf6f7c6afeffedab64034f1abc.jpg"];
//NSURL *url2 = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/faedab64034f78f07429df097a310a55b3191c2d.jpg"];
//NSURL *url3 = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/622762d0f703918f15e87fcb533d269759eec4f2.jpg"];
//NSURL *url4 = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/b2de9c82d158ccbf28afe2c51ad8bc3eb1354139.jpg"];
@end
