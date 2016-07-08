//
//  WXMediaMessage+messageConstruct.h
//  Fabbi
//
//  Created by zou145688 on 16/7/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "WXApiObject.h"

@interface WXMediaMessage (messageConstruct)
+ (WXMediaMessage *)messageWithTitle:(NSString *)title
                         Description:(NSString *)description
                              Object:(id)mediaObject
                          MessageExt:(NSString *)messageExt
                       MessageAction:(NSString *)action
                          ThumbImage:(UIImage *)thumbImage
                            MediaTag:(NSString *)tagName;
@end
