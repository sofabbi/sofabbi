//
//  ChatView.h
//  LZGAnimation
//
//  Created by wkr on 16/5/20.
//  Copyright © 2016年 pantao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PTPopoverPosition) {
    PTPopoverPositionLeft = 1,
    PTPopoverPositionRight,
};

@interface ChatView : UIView

@property (nonatomic, assign, readonly) PTPopoverPosition popoverPosition;

@property (nonatomic, assign) CGPoint arrowShowPoint;

@end
