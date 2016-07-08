//
//  ChatView.m
//  LZGAnimation
//
//  Created by wkr on 16/5/20.
//  Copyright © 2016年 pantao. All rights reserved.
//
#define DEGREES_TO_RADIANS(degrees) ((3.14159265359 * degrees) / 180)

#import "ChatView.h"

@interface ChatView()

@property (nonatomic, assign, readwrite) PTPopoverPosition popoverPosition;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, weak) UIView *containerView;

@end

@implementation ChatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
    self.contentColor = backgroundColor;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *arrow = [[UIBezierPath alloc] init];
    UIColor *contentColor = self.contentColor;
    // the point in the ourself view coordinator
    CGPoint arrowPoint = self.arrowShowPoint;
    CGSize arrowSize = CGSizeMake(11.0, 9.0);
    CGFloat cornerRadius = 5;
    CGSize size = self.bounds.size;
    
    switch (self.popoverPosition) {
        case PTPopoverPositionRight: {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, 0)];
            [arrow
             addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5, arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                                arrowSize.height + cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(270.0)
                           endAngle:DEGREES_TO_RADIANS(0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width, size.height - cornerRadius)];
            [arrow
             addArcWithCenter:CGPointMake(size.width - cornerRadius, size.height - cornerRadius)
             radius:cornerRadius
             startAngle:DEGREES_TO_RADIANS(0)
             endAngle:DEGREES_TO_RADIANS(90.0)
             clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, size.height)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, size.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(90)
                           endAngle:DEGREES_TO_RADIANS(180.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, arrowSize.height + cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, arrowSize.height + cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(180.0)
                           endAngle:DEGREES_TO_RADIANS(270)
                          clockwise:YES];
            [arrow
             addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5, arrowSize.height)];
        } break;
        case PTPopoverPositionLeft: {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, size.height)];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5,
                                              size.height - arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(cornerRadius, size.height - arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius,
                                                size.height - arrowSize.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(90.0)
                           endAngle:DEGREES_TO_RADIANS(180.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(180.0)
                           endAngle:DEGREES_TO_RADIANS(270.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, 0)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius, cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(270.0)
                           endAngle:DEGREES_TO_RADIANS(0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width,
                                              size.height - arrowSize.height - cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                                size.height - arrowSize.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(0)
                           endAngle:DEGREES_TO_RADIANS(90.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5,
                                              size.height - arrowSize.height)];
        } break;
    }
    [contentColor setFill];
    [arrow fill];
}

@end
