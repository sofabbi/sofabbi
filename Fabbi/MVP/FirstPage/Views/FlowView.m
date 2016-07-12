//
//  FlowView.m
//  MVP
//
//  Created by 刘志刚 on 16/5/16.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "FlowView.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface FlowView ()
{
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
}
@property (nonatomic, strong) NSNumber *contentId;
@end
@implementation FlowView

- (instancetype)initWithFrame:(CGRect)frame from:(NSString *)from{
    
    if (self=[super initWithFrame:frame]) {
        
        _from = from;
        self.backgroundColor = RGBA(0, 0, 0, 0);
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
        effe.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        //        [self addSubview:effe];
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
            [[UIToolbar appearance] setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
            [[UIToolbar appearance] setBackgroundColor:[UIColor whiteColor]];
        }
        [self addSubview:toolbar];
       
        //评论
        self.myCommitBtn = [MyUtils createButtonFrame:CGRectMake(30*kScreenWidthP, 10*kScreenWidthP, 70*kScreenWidthP, 20*kScreenWidthP)  title:@"评论" titleColor:[UIColor blackColor] backgroundColor:nil target:self action:@selector(myCommitBtn:)];
        _myCommitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _myCommitBtn.center = CGPointMake(kScreenWidth/4, 25*kScreenWidthP);
        [self.myCommitBtn setImage:[[UIImage imageNamed:@"fabbi_comment"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.myCommitBtn setImage:[UIImage imageNamed:@"fabbi_comment"] forState:UIControlStateSelected];
        _myCommitBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _myCommitBtn.backgroundColor = RGBA(0, 0, 0, 0);
        _myCommitBtn.titleLabel.backgroundColor = RGBA(0, 0, 0, 0);
        [self addSubview:self.myCommitBtn];
        //        线
        UILabel *lineL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1*kScreenWidthP, 12*kScreenWidthP)];
        lineL.center = CGPointMake(kScreenWidth/2, frame.size.height/2);
        lineL.backgroundColor = RGBA(216, 216, 216, 1);
        [self addSubview:lineL];
        
        CGFloat startX = CGRectGetMaxX(self.myCommitBtn.frame)+5*kScreenWidthP;
        _starBtn = [MyUtils createButtonFrame:CGRectMake(startX, 10*kScreenWidthP, 70*kScreenWidthP, 20*kScreenWidthP)  title:@"想要" titleColor:[UIColor blackColor] backgroundColor:nil target:self action:@selector(starBtn:)];
        
        _starBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _starBtn.center = CGPointMake(kScreenWidth*3/4, 25*kScreenWidthP);
        _starBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 9*kScreenWidthP);
        _starBtn.backgroundColor = RGBA(0, 0, 0, 0);
        _starBtn.titleLabel.backgroundColor = RGBA(0, 0, 0, 0);
        [self addSubview:_starBtn];
        if ([from isEqualToString:@"DetailPageViewController"]) {
            
            [_starBtn setTitle:@"想要" forState:UIControlStateNormal];
            [_starBtn setImage:[UIImage imageNamed:@"fabbi_want"] forState:UIControlStateNormal];
            [_starBtn setImage:[UIImage imageNamed:@"fabbi_wanted"] forState:UIControlStateSelected];
            
        }else{
            [_starBtn setTitle:@"收藏" forState:UIControlStateNormal];
            [_starBtn setImage:[UIImage imageNamed:@"fabbi_collection"] forState:UIControlStateNormal];
            [_starBtn setImage:[UIImage imageNamed:@"fabbi_collectioned"] forState:UIControlStateSelected];
        }
        
    }
    return self;
}
- (void)contentDictionary:(NSDictionary *)dic{
    _contentId = [dic objectForKey:@"id"];
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    if (uid) {
        if ([_from isEqualToString:@"DetailPageViewController"]){
            NSNumber *userLove = [dic objectForKey:@"userHasLove"];
            if ([userLove isEqualToNumber:[NSNumber numberWithInteger:1]]) {
                _starBtn.selected = YES;
                
            }else{
                _starBtn.selected = NO;
            }
        }else{
            NSNumber *userHascollection = [dic objectForKey:@"userHascollection"];
            if ([userHascollection isEqualToNumber:[NSNumber numberWithInteger:1]]) {
                _starBtn.selected = YES;
                
            }else{
                _starBtn.selected = NO;
                
            }
        }
    }
    
}

#pragma flowViewDelegate
- (void)myCommitBtn:(UIButton *)btn{
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    
    if ([NSNumber isBlankNumber:_contentId]) {
        [self.delegate noContent];
    }else{
        if (uid) {
            [self.delegate comment];
        }else{
            [self.delegate tologin];
        }
    }
    
}

- (void)starBtn:(UIButton *)btn{
    
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    if ([NSNumber isBlankNumber:_contentId]) {
        [self.delegate noContent];
    }else if (uid) {
        BOOL NotLike = btn.selected;
        BOOL isLike = !btn.selected;
        
        [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
            btn.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            
        } completion:^(BOOL finished)
         {
             if (finished) {
                 btn.imageView.transform = CGAffineTransformMakeScale(1, 1);
                 [self.delegate want:isLike sucess:^(id responseObject) {
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
    [self.delegate toLink];
    
}

@end
