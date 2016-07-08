//
//  ButtonLarge.m
//  Fabbi
//
//  Created by zou145688 on 16/6/12.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "ButtonLarge.h"

@implementation ButtonLarge
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)pTitle withButtonType:(LargeButtonType)pType
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitle:pTitle forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18.f];
        self.layer.cornerRadius = 2.f;
        self.clipsToBounds = YES;
        if (pType == kMainButtonType) {
            [self setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [self setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        }else{
            
            [self setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [self setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        }
    }
    return self;
}
- (UIImage *)createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
