//
//  WXMediaMessage+messageConstruct.m
//  Fabbi
//
//  Created by zou145688 on 16/7/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "WXMediaMessage+messageConstruct.h"

@implementation WXMediaMessage (messageConstruct)
+ (WXMediaMessage *)messageWithTitle:(NSString *)title
                         Description:(NSString *)description
                              Object:(id)mediaObject
                          MessageExt:(NSString *)messageExt
                       MessageAction:(NSString *)action
                          ThumbImage:(UIImage *)thumbImage
                            MediaTag:(NSString *)tagName {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = mediaObject;
    message.messageExt = messageExt;
    message.messageAction = action;
    message.mediaTagName = tagName;
    [message setThumbImage:thumbImage];
    return message;
}

@end
