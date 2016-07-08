//
//  Cuetom_alert.m
//  Fabbi
//
//  Created by zou145688 on 16/6/16.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "Cuetom_alert.h"
static NSInteger kPopUpAView = 1234;
@interface Cuetom_alert()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) BOOL shouldShow;
@end
@implementation Cuetom_alert
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)pTitle message:(NSString *)pMessage delegate:(id)pDelegate andButtons:(NSArray *)pButtons{
    CGFloat frameHeight = pMessage ? 124.f : 99.f;
    if (!pTitle) {
        frameHeight -= 25.f;
    }
    self = [super initWithFrame:CGRectMake(0.f, 0.f, 270.f, frameHeight)];
    if (self) {
        if (pMessage.length > 0) {
            _shouldShow = YES;
        }
        self.layer.backgroundColor = [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f].CGColor;
        self.layer.cornerRadius = 4.f;
        self.clipsToBounds = YES;
        
        _delegate = pDelegate;
        
        // Initialization code
        UILabel *titleLabel;
        if (pTitle) {
            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 150.f, 18.f)];
            titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.f];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = pTitle;
            titleLabel.center = CGPointMake(CGRectGetMidX(self.frame), 23.f);
            [self addSubview:titleLabel];
        }
        
        
        
        
        if (pMessage) {
            UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 250.f, 15.f)];
            
            
            NSRange range = [pMessage rangeOfString:@"\n"];
            if (range.location != NSNotFound) {
                descLabel.frame = CGRectMake(0.f, 0.f, 250.f, 43.f);
                self.frame = CGRectMake(0.f, 0.f, 270.f, frameHeight + 16.f);
                descLabel.numberOfLines = 2;
                descLabel.center = CGPointMake(CGRectGetMidX(self.frame), titleLabel.frame.origin.y + 40.f);
            }else{
                CGFloat gap=(titleLabel)?38.0f:30.0f;
                
                
                descLabel.center = CGPointMake(CGRectGetMidX(self.frame), titleLabel.frame.origin.y + gap);
            }
            
            descLabel.font = pTitle ? [UIFont systemFontOfSize:14.f] : [UIFont boldSystemFontOfSize:14.f];
            descLabel.textAlignment = NSTextAlignmentCenter;
            descLabel.text = pMessage;
            //            [descLabel.layer setBorderWidth:1.0f];
            
            [self addSubview:descLabel];
        }
        
        
        
        
        if (pButtons.count == 1) {
            
            NSString *titleString = pButtons[0];
            
            UIButton *buttonL = [[UIButton alloc] initWithFrame:CGRectMake(-3.f, self.frame.size.height - 47.f, 276.f, 48.f)];
            [buttonL setTitle:titleString forState:UIControlStateNormal];
            buttonL.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
            buttonL.layer.borderColor = [UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1.f].CGColor;
            buttonL.layer.borderWidth = .5f;
            [buttonL setTitleColor:kColorM forState:UIControlStateNormal];
            //            [buttonL setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [buttonL setBackgroundImage:[self createImageWithColor:kColorCellSelected] forState:UIControlStateHighlighted];
            [buttonL addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
            buttonL.tag = 0;
            [self addSubview:buttonL];
        }else if (pButtons.count == 2){
            UIButton *buttonL = [[UIButton alloc] initWithFrame:CGRectMake(-3.f, self.frame.size.height - 47.f, 139.f, 48.f)];
            [buttonL setTitle:pButtons[0] forState:UIControlStateNormal];
            buttonL.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
            buttonL.layer.borderColor = [UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1.f].CGColor;
            buttonL.layer.borderWidth = .5f;
            [buttonL setTitleColor:RGBA(67, 181, 223, 1) forState:UIControlStateNormal];
            //            [buttonL setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [buttonL setBackgroundImage:[self createImageWithColor:kColorCellSelected] forState:UIControlStateHighlighted];
            [buttonL addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
            buttonL.tag = 0;
            [self addSubview:buttonL];
            
            UIButton *buttonR = [[UIButton alloc] initWithFrame:CGRectMake(135.f,  self.frame.size.height - 47.f, 136.f, 48.f)];
            [buttonR setTitle:pButtons[1] forState:UIControlStateNormal];
            buttonR.titleLabel.font =  [UIFont fontWithName:@"Helvetica" size:14.f];
            buttonR.layer.borderColor = [UIColor colorWithRed:217.f/255.f green:217.f/255.f blue:217.f/255.f alpha:1.f].CGColor;
            buttonR.layer.borderWidth = .5f;
            [buttonR setTitleColor:RGBA(67, 181, 223, 1) forState:UIControlStateNormal];
            //            [buttonR setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [buttonR setBackgroundImage:[self createImageWithColor:kColorCellSelected] forState:UIControlStateHighlighted];
            [buttonR addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
            buttonR.tag = 1;
            [self addSubview:buttonR];
        }
    }
    return self;
}

- (void)show{
    if (!_shouldShow) return;
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    if ([window viewWithTag:kPopUpAView]) {
        for (UIView *view in window.subviews) {
            [view removeFromSuperview];
        }
        [[window viewWithTag:kPopUpAView] removeFromSuperview];
    }
    
    _bgView = [[UIView alloc] initWithFrame:window.frame];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = .5f;
    _bgView.tag = kPopUpAView;
    [window addSubview:_bgView];
    
    self.center = CGPointMake(CGRectGetMidX(window.bounds), CGRectGetMidY(window.bounds));
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    [self setTransform:CGAffineTransformMakeScale(0.5f, 0.5f)];
    
    
    __weak Cuetom_alert *weakSelf = self;
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [weakSelf setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    } completion:NULL];
    
}

- (void)doClick:(UIButton *)sender{
    
    if (self.delegate) {
        [self.delegate popAlertView:self clickedButtonAtIndex:sender.tag];
    }
    
    __weak Cuetom_alert *weakSelf = self;
    [UIView animateWithDuration:.4f delay:.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.bgView.alpha = 0.f;
        weakSelf.alpha = 0.f;
    } completion:^(BOOL finished) {
        [weakSelf.bgView removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

- (void)setDelegate:(id<custom_alertViewDelegate>)delegate{
    if (_delegate == delegate) {
        return;
    }
    _delegate = delegate;
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

@end
