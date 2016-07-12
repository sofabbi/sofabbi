//
//  NSNumber+Judge.m
//  Fabbi
//
//  Created by zou145688 on 16/7/10.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "NSNumber+Judge.h"

@implementation NSNumber (Judge)
//判断字符串是否为空
+ (BOOL) isBlankNumber:(NSNumber *)number {
    if (number == nil || number == NULL) {
        return YES;
    }
    if ([number isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}
@end
