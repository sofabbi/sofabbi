//
//  ShareView.m
//  Fabbi
//
//  Created by zou145688 on 16/6/12.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "ShareView.h"
#import "ButtonLarge.h"
static CGFloat const kElementVerticalGap = 10.f;

@interface ShareView ()
{
    UIButton *aButton;
    UIButton *bButton;
    UIButton *cButton;
    UIButton *dButton;
}
@property (nonatomic, strong) UIView *fullBgView;
@property (nonatomic, strong) UIView *sharePannelView;
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) WDButtonLarge *btn_cancel;
@property (nonatomic) CGRect fullFrame;
@property (nonatomic, strong) ButtonLarge *btn_cancel;
@property (nonatomic) BOOL allowSharing;

@property (nonatomic) CGFloat elementsLateY;
@end
@implementation ShareView
- (id)initWithCanBeShared:(BOOL)canBeShared buttonTitles:(NSArray *)items stylizeButtonIndex:(NSInteger)index andDelegate:(id)pDelegate{
    self = [super init];
    if (self) {
        _elementsLateY = 0.f;
        _sharePannelView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, kScreenHeight)];
        _sharePannelView.backgroundColor = [UIColor clearColor];
        [self addSubview:_sharePannelView];
        _delegate = pDelegate;
        if (canBeShared) {
            _elementsLateY = 13.f;
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, _elementsLateY, kScreenWidth, 20.f)];
            _titleLabel.font = [UIFont systemFontOfSize:16.f];
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.text = @"分享到";
            [_sharePannelView addSubview:_titleLabel];
            _elementsLateY += _titleLabel.frame.size.height+52*kScreenWidthP;
            
            [self setupSocialButtons];
        }
//        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:items];
//        [self setupButtonItems:array stylizeIndex:index];

    }
    return self;
}
- (void)showInView:(UIView *)pView{
    [pView addSubview:self];
    self.frame = CGRectMake(0, 0, pView.frame.size.width, pView.frame.size.height);
    _fullFrame = CGRectMake(0, 0, pView.frame.size.width, pView.frame.size.height);
    _fullBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pView.frame.size.width, pView.frame.size.height)];
    _fullBgView.backgroundColor = [UIColor clearColor];
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
    effe.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_fullBgView addSubview:effe];

    [self addSubview:_fullBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goDisappear)];
    [_fullBgView addGestureRecognizer:tap];
    
    __weak ShareView *weakSelf = self;
     
    [self bringSubviewToFront:_sharePannelView];
    CGRect viewFrame = _sharePannelView.frame;
    viewFrame.origin.y = pView.frame.size.height;
    viewFrame.size.height = _elementsLateY + 13.f;
    _sharePannelView.frame = viewFrame;
    viewFrame.origin.y = 240*kScreenWidthP;
    weakSelf.sharePannelView.frame = viewFrame;

    
}

- (void)setupSocialButtons{
    
    CGFloat iconHeight = 50.f;
    CGFloat iconCenterY = _elementsLateY + iconHeight * .5f;
    CGFloat btnStartX = 53*kScreenWidthP;
    CGFloat btnSpaceX = 37*kScreenWidthP;
    CGFloat btnW = 40*kScreenWidthP;
    aButton = [self buildButtonWithTitle:nil andImageName:@"fabbi_wechat" andTag:WDSHARE_WEIXIN];
    aButton.center = CGPointMake(btnStartX+btnW/2, iconCenterY);
   
    [_sharePannelView addSubview:aButton];
    
    bButton = [self buildButtonWithTitle:nil andImageName:@"fabbi_wechat_moment" andTag:WDSHARE_FRIEND_CIRCLE];
    bButton.center = CGPointMake(btnStartX+btnW*3/2+btnSpaceX, iconCenterY);
    
    [_sharePannelView addSubview:bButton];
    
    cButton = [self buildButtonWithTitle:nil andImageName:@"fabbi_sina" andTag:WDSHARE_SINA];
    cButton.center = CGPointMake(btnStartX+btnW*5/2+btnSpaceX*2, iconCenterY);
    [_sharePannelView addSubview:cButton];
    
    dButton = [self buildButtonWithTitle:nil andImageName:@"fabbi_qq" andTag:WDSHARE_QQ_ZONE];
    dButton.center = CGPointMake(btnStartX+btnW*7/2+btnSpaceX*3, iconCenterY);
    [_sharePannelView addSubview:dButton];
    
    _elementsLateY += iconHeight;
    _elementsLateY += kElementVerticalGap;
    _elementsLateY += 13.f;
  
    
}
- (void)setupButtonItems:(NSArray *)pArray stylizeIndex:(NSInteger)pIndex{
    
    UILabel *lineL = [[UILabel alloc]initWithFrame:CGRectMake(0, _elementsLateY, kScreenWidth, 0.25f*kScreenWidthP)];
    lineL.backgroundColor = [UIColor blackColor];
    [_sharePannelView addSubview:lineL];
    CGFloat buttonHeight = 24.f*kScreenWidthP;
    
    _elementsLateY += 7.f;
    
    for (NSInteger i = 0; i < pArray.count; i++) {
        LargeButtonType type = (i == pIndex) ? kMainButtonType : kSubButtonType;
        ButtonLarge *tButton = [[ButtonLarge alloc] initWithFrame:CGRectMake(0, _elementsLateY, kScreenWidth, buttonHeight) andTitle:pArray[i] withButtonType:type];
        [tButton addTarget:self action:@selector(handleTapToShareAction:) forControlEvents:UIControlEventTouchUpInside];
        tButton.tag = i;
        //        [aButton setTitleColor:kColorM forState:UIControlStateNormal];
        _elementsLateY += buttonHeight;
        [_sharePannelView addSubview:tButton];
    }
    
}

- (UIButton *)buildButtonWithTitle:(NSString *)pTitle andImageName:(NSString *)pImageName andTag:(NSInteger)pTag{
    UIButton *fButton = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    [fButton setImage:[UIImage imageNamed:pImageName] forState:UIControlStateNormal];
    [fButton setImage:[UIImage imageNamed:pImageName] forState:UIControlStateHighlighted];
    [fButton setTitle:pTitle forState:UIControlStateNormal];
    [fButton setTitleColor:[UIColor colorWithRed:88.f/255.f green:88.f/255.f blue:88.f/255.f alpha:1.f] forState:UIControlStateNormal];
//    [aButton.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
//    [aButton setImageEdgeInsets:UIEdgeInsetsMake(0.f, 7.f, 26.f, 7.f)];
    [fButton setTag:pTag];
    [fButton addTarget:self action:@selector(handleTapToShareAction:) forControlEvents:UIControlEventTouchUpInside];
    //aButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [aButton setTitleEdgeInsets:UIEdgeInsetsMake(55.f, -50.f, 0.f, 0)];
    return fButton;
}

- (void)handleTapToShareAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedItem:)]) {
        [self.delegate didSelectedItem:sender];
    }
    [self goDisappear];
}

- (void)goDisappear{
    CGRect viewFrame = _sharePannelView.frame;
    CGFloat targetY = _fullFrame.size.height;
    viewFrame.origin.y = targetY;
    
    __weak ShareView *weakSelf = self;
    [UIView animateWithDuration:0 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.sharePannelView.frame = viewFrame;
        
    } completion:^(BOOL finished) {
        //
        
        [weakSelf.sharePannelView removeFromSuperview];
    }];
    
    [UIView animateWithDuration:.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.fullBgView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [weakSelf.fullBgView removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}


@end
