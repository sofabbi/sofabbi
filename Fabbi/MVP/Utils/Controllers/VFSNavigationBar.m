//
//  VFSNavigationBar.m
//  Fabbi
//
//  Created by zou145688 on 16/7/11.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "VFSNavigationBar.h"
const CGFloat VFSNavigationBarHeightIncrease = 38.f;
@implementation VFSNavigationBar
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    
    [self setTitleVerticalPositionAdjustment:-(VFSNavigationBarHeightIncrease) forBarMetrics:UIBarMetricsDefault];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSArray *classNamesToReposition = @[@"_UINavigationBarBackground"];
    
    for (UIView *view in [self subviews]) {
        
        if ([classNamesToReposition containsObject:NSStringFromClass([view class])]) {
            
            CGRect bounds = [self bounds];
            CGRect frame = [view frame];
            frame.origin.y = bounds.origin.y + VFSNavigationBarHeightIncrease - 20.f;
            frame.size.height = bounds.size.height + 20.f;
            
            [view setFrame:frame];
        }
    }
}
@end
