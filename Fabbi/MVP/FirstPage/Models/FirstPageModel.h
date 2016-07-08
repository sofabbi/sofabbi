//
//  FirstPageModel.h
//  MVP
//
//  Created by 刘志刚 on 16/4/22.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class FirstItemVoModel;
//@class FirstSpecialVoModel;
//@interface FirstItemVoModel : NSObject
//@property (nonatomic,strong) NSString *brandNotes;
//@property (nonatomic,strong) NSString *categoryLevalOne;
//@property (nonatomic,strong) NSString *categoryLevalTwo;
//@property (nonatomic,strong) NSString *categoryLevalThree;
//@property (nonatomic,strong) NSString *categoryOneName;
//@property (nonatomic,strong) NSString *categoryTwoName;
//@property (nonatomic,strong) NSString *categoryThreeName;
//@property (nonatomic,strong) NSString *extTime;
//
//@property (nonatomic,strong) NSString *itemvoid;
//@property (nonatomic,strong) NSString *itemBrandId;
//@property (nonatomic,strong) NSString *itemCategoryId;
//@property (nonatomic,strong) NSString *itemContens;
//@property (nonatomic,strong) NSString *itemCreateTime;
//@property (nonatomic,strong) NSString *itemCreateUser;
//@property (nonatomic,strong) NSString *itemCreateUserName;
//@property (nonatomic,strong) NSString *itemEditTime;
//
//@property (nonatomic,strong) NSString *itemEditUser;
//@property (nonatomic,strong) NSString *itemEditUserName;
//@property (nonatomic,strong) NSString *itemExamTime;
//@property (nonatomic,strong) NSString *itemExamUser;
//@property (nonatomic,strong) NSString *itemExamUserName;
//@property (nonatomic,strong) NSArray *itemFileList;
//@property (nonatomic,strong) NSString *itemName;
//@property (nonatomic,strong) NSString *itemNotes;
//
//@property (nonatomic,strong) NSString *itemPrice;
//@property (nonatomic,strong) NSString *itemPublishTime;
//@property (nonatomic,strong) NSString *itemPublishUser;
//@property (nonatomic,strong) NSString *itemPublishUserName;
//@property (nonatomic,strong) NSString *itemSourceName;
//@property (nonatomic,strong) NSString *itemSourceUrl;
//@property (nonatomic,strong) NSString *itemStatus;
//@property (nonatomic,strong) NSString *itemUpdateTime;
//
//@property (nonatomic,strong) NSString *itemUpdateUser;
//@property (nonatomic,strong) NSString *itemUpdateUserName;
//@property (nonatomic,strong) NSString *loginId;
//@property (nonatomic,strong) NSString *loginName;
//@property (nonatomic,strong) NSString *loveSum;
//@property (nonatomic,strong) NSString *resultCode;
//@property (nonatomic,strong) NSString *resultMessage;
//
//@end
//
//@interface FirstSpecialVoModel : NSObject
//@property (nonatomic,strong) NSString *specialUpdateUser;
//@property (nonatomic,strong) NSString *specialStatus;
//@property (nonatomic,strong) NSString *specialCreateUser;
//@property (nonatomic,strong) NSString *specialName;
//@property (nonatomic,strong) NSString *specialid;
//@property (nonatomic,strong) NSString *specialEditUser;
//@property (nonatomic,strong) NSString *specialUpdateTime;
//@property (nonatomic,strong) NSString *specialSourceName;
//
//@property (nonatomic,strong) NSString *specialExamTime;
//
//@property (nonatomic,strong) NSString *specialCategoryId;
//@property (nonatomic,strong) NSString *specialPublishTime;
//@property (nonatomic,strong) NSString *specialPublishUserName;
//@property (nonatomic,strong) NSString *collectionSum;
//@property (nonatomic,strong) NSArray *specialCnotensList;
//@property (nonatomic,strong) NSString *specialCategoryName;
//
//@property (nonatomic,strong) NSString *loginName;
//@property (nonatomic,strong) NSString *specialExamUserName;
//@property (nonatomic,strong) NSString *specialNotes;
//@property (nonatomic,strong) NSString *specialEditUserName;
//@property (nonatomic,strong) NSString *specialExamUser;
//@property (nonatomic,strong) NSString *specialCreateTime;
//
//@property (nonatomic,strong) NSString *specialEditTime;
//@property (nonatomic,strong) NSString *specialLogoUrl;
//@property (nonatomic,strong) NSString *extTime;
//@property (nonatomic,strong) NSString *loginId;
//@property (nonatomic,strong) NSString *specialPublishUser;
//@property (nonatomic,strong) NSString *specialUpdateUserName;
//@property (nonatomic,strong) NSString *specialCreateUserName;
//@end



@interface FirstPageModel : NSObject

@property (nonatomic,strong) NSString *resultCode;
@property (nonatomic,strong) NSNumber *createTime;
@property (nonatomic,strong) NSString *resultMessage;
@property (nonatomic,strong) NSNumber *goodsType;
@property (nonatomic, strong)NSDictionary *firstItemVoModel;
@property (nonatomic,strong) NSDictionary *firstSpecialVoModel;


@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *secletStr;
@property (nonatomic,strong) NSString *iconStr;
//@property (nonatomic,strong) NSString *goodsType;
@end
