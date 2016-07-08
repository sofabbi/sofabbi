//
//  NSTimer+Addition.m
//  Fabbi
//
//  Created by zou145688 on 16/6/8.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
