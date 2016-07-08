//
//  SendMessageToWXReq+requestWithTextOrMediaMessage.m
//  Fabbi
//
//  Created by zou145688 on 16/7/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"

@implementation SendMessageToWXReq (requestWithTextOrMediaMessage)
+ (SendMessageToWXReq *)requestWithText:(NSString *)text
                         OrMediaMessage:(WXMediaMessage *)message
                                  bText:(BOOL)bText
                                InScene:(enum WXScene)scene {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init] ;
    req.bText = bText;
    req.scene = scene;
    if (bText)
        req.text = text;
    else
        req.message = message;
    return req;
}
@end
