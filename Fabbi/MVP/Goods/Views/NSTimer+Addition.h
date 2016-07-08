//
//  NSTimer+Addition.h
//  Fabbi
//
//  Created by zou145688 on 16/6/8.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
