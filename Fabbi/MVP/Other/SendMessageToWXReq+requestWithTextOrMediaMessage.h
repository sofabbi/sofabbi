//
//  SendMessageToWXReq+requestWithTextOrMediaMessage.h
//  Fabbi
//
//  Created by zou145688 on 16/7/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "WXApiObject.h"

@interface SendMessageToWXReq (requestWithTextOrMediaMessage)
+ (SendMessageToWXReq *)requestWithText:(NSString *)text
                         OrMediaMessage:(WXMediaMessage *)message
                                  bText:(BOOL)bText
                                InScene:(enum WXScene)scene;
@end
