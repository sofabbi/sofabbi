//
//  NSArray+judge.m
//  Fabbi
//
//  Created by zou145688 on 16/7/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "NSArray+judge.h"

@implementation NSArray (judge)
//判断字符串是否为空
+ (BOOL) isBlankArray:(NSArray *)array {
    if (array == nil || array == NULL) {
        return YES;
    }
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (array.count <=0) {
        return YES;
    }
    return NO;
}
@end
