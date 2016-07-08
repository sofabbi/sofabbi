
//
//  LinkView.m
//  MVP
//
//  Created by 刘志刚 on 16/5/11.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "LinkView.h"
#import "MyUtils.h"
@implementation LinkView
- (instancetype)initWithFrame:(CGRect)frame isShowCommit:(BOOL)isShow{
    if (self = [super initWithFrame:frame]) {
        _titleLable = [MyUtils createLabelFrame:CGRectMake(20*kScreenWidthP, 20*kScreenWidthP, 200*kScreenWidthP, 45*kScreenWidthP) title:@"【Shredded Tee】瑜伽罩衫" font:15 textAlignment:NSTextAlignmentLeft textColor:RGBA(34, 34, 34, 1) backgroundColor:nil numberOfLines:0 layerCornerRadius:0];
        _titleLable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _titleLable.backgroundColor = [UIColor whiteColor];
        _titleLable.center = CGPointMake(120*kScreenWidthP, self.frame.size.height/2);
        [self addSubview:_titleLable];
       
        
        self.loveBtn = [MyUtils createButtonFrame:CGRectMake(frame.size.width - 90*kScreenWidthP, 0, 72*kScreenWidthP, 40*kScreenWidthP)  title:@"想要" titleColor:[UIColor blackColor] backgroundColor:nil target:self action:@selector(loveBtn:)];
        _loveBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _loveBtn.center = CGPointMake(frame.size.width - 56*kScreenWidthP, self.frame.size.height/2);
        [self.loveBtn setImage:[UIImage imageNamed:@"fabbi_popup_want"]forState:UIControlStateNormal];
        [self.loveBtn setImage:[UIImage imageNamed:@"fabbi_popup_wanted"] forState:UIControlStateSelected];
        _loveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 13*kScreenWidthP);
        _loveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _loveBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.loveBtn];
        
        self.toLinkBtn = [MyUtils createButtonFrame:CGRectMake(0.35*kScreenWidth,0,150*kScreenWidthP, 34*kScreenWidthP) title:@"¥300 | 直达链接" selectTitle:@"¥300 | 直达链接"  titleColor:[UIColor whiteColor] bgImageName:nil selectImageName:nil backgroundColor:RGBA(61,181,223,1) layerCornerRadius:15*kScreenWidthP target:self action:@selector(toLinkBtn:)];
        _toLinkBtn.center = CGPointMake(CGRectGetWidth(self.frame)-100*kScreenWidthP, 40*kScreenWidthP);
        self.toLinkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.toLinkBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//        [self addSubview:self.toLinkBtn];
    }
    return self;
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    _titleLable.text = [dic objectForKey:@"itemName"];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.commitBtn = [MyUtils createButtonFrame:CGRectMake(10*kScreenWidthP, 0, 30*kScreenWidthP, 30*kScreenWidthP)  title:@"评论" titleColor:nil backgroundColor:nil target:self action:@selector(commitBtn:)];
        [self.commitBtn setImage:[[UIImage imageNamed:@"white-minetalk"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        _commitBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10*kScreenWidthP);
        [self addSubview:self.commitBtn];
        
        self.loveBtn = [MyUtils createButtonFrame:CGRectMake(50*kScreenWidthP, 0, 44*kScreenWidthP, 40*kScreenWidthP)  title:@"想要" titleColor:nil backgroundColor:nil target:self action:@selector(loveBtn:)];
         [self.loveBtn setImage:[[UIImage imageNamed:@"white-minewant"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.loveBtn setImage:[UIImage imageNamed:@"black-minewant"] forState:UIControlStateSelected];
        _loveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 9*kScreenWidthP);
        [self addSubview:self.loveBtn];
       
        self.toLinkBtn = [MyUtils createButtonFrame:CGRectMake(0.35*kScreenWidth,0,0.55*kScreenWidth, 34*kScreenWidthP) title:@"¥300 | 直达链接" selectTitle:@"¥300 | 直达链接"  titleColor:[UIColor whiteColor] bgImageName:nil selectImageName:nil backgroundColor:RGBA(51,51,51,1) layerCornerRadius:15*kScreenWidthP target:self action:@selector(toLinkBtn:)];
        self.toLinkBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.toLinkBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.toLinkBtn];
    }
    return self;
}

- (void)commitBtn:(UIButton *)btn{
    
}
- (void)loveBtn:(UIButton *)btn{
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    if (uid) {
        BOOL isLike = !btn.selected;
        BOOL NotLike = btn.selected;
        [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            btn.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);

        } completion:^(BOOL finished)
         {
             if (finished) {
            
                 [self.delegate want:isLike  sucess:^(id responseObject) {
                     btn.selected = isLike;
                 } failure:^(NSError *error) {
                     btn.selected = NotLike;
                 }];
                 
             }
         }];
        

    }else{
       [self.delegate tologin]; 
    }
    
}
- (void)shakeAnimationForView:(UIView *) view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 1, position.y);
    CGPoint y = CGPointMake(position.x - 1, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}
// 去链接
- (void)toLinkBtn:(UIButton *)btn{
    NSLog(@"直达链接");
    
}
@end
