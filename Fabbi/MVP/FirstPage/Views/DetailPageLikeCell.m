//
//  DetailPageLikeCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "DetailPageLikeCell.h"
#import "MyUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DetailPageLikeCell ()
@property (nonatomic, strong) UIButton *btLike;
@property (nonatomic, strong) UILabel *bllike;
@property (nonatomic, strong) NSArray *likeUsersArray;
@end
@implementation DetailPageLikeCell
@synthesize likeUsers;
@synthesize imageView0, imageView1, imageView2, imageView3, imageView4, imageView5, imageView6;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        CGFloat lb_likeW = 68.f*kScreenWidthP;
        UILabel *lb_like = [MyUtils createLabelFrame:CGRectMake(kScreenWidth - lb_likeW -20.f, 12.f*kScreenWidthP, lb_likeW, 17.f*kScreenWidthP) title:@"0人想要" font:12 textAlignment:NSTextAlignmentLeft textColor:RGBA(34, 34, 34, 0.5) backgroundColor:[UIColor clearColor] numberOfLines:1 layerCornerRadius:0];
        _bllike = lb_like;
        
        
        [self addSubview:lb_like];
        CGFloat btlikeW = 30.f;
        CGFloat btlikeX = kScreenWidth - lb_likeW - 20.f - btlikeW;
        UIButton *bt_like = [[UIButton alloc] initWithFrame:CGRectMake(btlikeX, 6.f, 30.f, 30.f)];
        bt_like.userInteractionEnabled = NO;
        bt_like.imageEdgeInsets = UIEdgeInsetsMake(8.f, 11.f, 8.f, 4.f);
        
        [bt_like setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [bt_like setImage:[UIImage imageNamed:@"like_hight"] forState:UIControlStateHighlighted];
        [bt_like setImage:[UIImage imageNamed:@"like_hight"] forState:UIControlStateSelected];
        [bt_like addTarget:self action:@selector(tapLikeButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt_like];
    
        _btLike = bt_like;
        float marginLeft = 32.5f*kScreenWidthP;
        float gapWidth = 35.f*kScreenWidthP;
        
        //大屏
        BOOL showMore = NO;
        if  ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)) {
            if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)]) {
                if (([UIScreen mainScreen].bounds.size.height >= 600.0f) ) {
                    gapWidth = 35.8f;
                    showMore = YES;
                }
            }
        }
        
        
        imageView0 = [self buildImageViewAt:marginLeft];
        imageView1 = [self buildImageViewAt:marginLeft + gapWidth * 1.f];
        imageView2 = [self buildImageViewAt:marginLeft + gapWidth * 2.f];
        imageView3 = [self buildImageViewAt:marginLeft + gapWidth * 3.f];
        imageView4 = [self buildImageViewAt:marginLeft + gapWidth * 4.f];
        imageView5 = [self buildImageViewAt:marginLeft + gapWidth * 5.f];
        imageView6 = [self buildImageViewAt:marginLeft + gapWidth * 6.f];
        
    }
    return self;
}
- (UIImageView *)buildImageViewAt:(float)x{
    UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
    aImageView.image = [UIImage imageNamed:@"Avatar_default"];
    aImageView.backgroundColor = [UIColor redColor];
    aImageView.center = CGPointMake(x, 20.f);
    aImageView.hidden = NO;
    aImageView.userInteractionEnabled = YES;
    [self addSubview:aImageView];
    aImageView.layer.cornerRadius = 12.5f;
    aImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnAvatarView:)];
    [aImageView addGestureRecognizer:tap];
    
    return aImageView;
}
#pragma mark - 设置头像

- (void)setAvatarWithUser:(NSString *)pUser toImageView:(UIImageView *)pImageView{
    
    
    //    __weak UIImageView *weakView = pImageView;
    
    NSString *urlString = [NSString stringWithFormat:@"%@",pUser];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [pImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default"] options:SDWebImageRetryFailed];
    });
    
}
- (void)setLikeContent:(NSDictionary *)content{
    likeUsers = [content objectForKey:@"userHobbyList"];
    imageView0.hidden = imageView1.hidden = imageView2.hidden = imageView3.hidden = imageView4.hidden = imageView5.hidden = imageView6.hidden  = YES;
    long usersCount = likeUsers.count;
    if (usersCount > 0) {
        _bllike.text = [NSString stringWithFormat:@"%ld人想要",usersCount];
        [_btLike setImage:[UIImage imageNamed:@"want-to"] forState:UIControlStateNormal];
        NSString *user0 = [likeUsers[0] objectForKey:@"itemFileUrl"];
        [self setAvatarWithUser:user0 toImageView:imageView0];
        imageView0.hidden = NO;
        imageView1.hidden = imageView2.hidden = imageView3.hidden = imageView4.hidden = imageView5.hidden = imageView6.hidden = YES;
        if (usersCount>1) {
            NSString *user1 = [likeUsers[1] objectForKey:@"itemFileUrl"];
            [self setAvatarWithUser:user1 toImageView:imageView1];
            imageView0.hidden = imageView1.hidden = NO;
            imageView2.hidden = imageView3.hidden = imageView4.hidden = imageView5.hidden =imageView6.hidden= YES;
        }
        if (usersCount>2) {
            NSString *user2 = [likeUsers[2] objectForKey:@"itemFileUrl"];;
            [self setAvatarWithUser:user2 toImageView:imageView2];
            imageView0.hidden = imageView1.hidden = imageView2.hidden = NO;
            imageView3.hidden = imageView4.hidden = imageView5.hidden=imageView6.hidden = YES;
        }
        if (usersCount>3) {
            NSString *user3 = [likeUsers[3] objectForKey:@"itemFileUrl"];;
            [self setAvatarWithUser:user3 toImageView:imageView3];
            imageView0.hidden = imageView1.hidden = imageView2.hidden = imageView3.hidden = NO;
            imageView4.hidden = imageView5.hidden=imageView6.hidden = YES;
        }
        if (usersCount>4) {
            NSString *user4 =  [likeUsers[4] objectForKey:@"itemFileUrl"];;
            [self setAvatarWithUser:user4 toImageView:imageView4];
            imageView0.hidden = imageView1.hidden = imageView2.hidden = imageView3.hidden = imageView4.hidden = NO;
            imageView5.hidden=imageView6.hidden = YES;
        }
        if (usersCount>5) {
            NSString *user5 =  [likeUsers[5] objectForKey:@"itemFileUrl"];;
            [self setAvatarWithUser:user5 toImageView:imageView5];
            imageView0.hidden = imageView1.hidden = imageView2.hidden = imageView3.hidden = imageView4.hidden = imageView5.hidden = NO;
            imageView6.hidden = YES;
        }
        
        if (usersCount>6) {
            NSString *user6 =  [likeUsers[6] objectForKey:@"itemFileUrl"];;
            [self setAvatarWithUser:user6 toImageView:imageView6];
            imageView0.hidden = imageView1.hidden = imageView2.hidden = imageView3.hidden = imageView4.hidden = imageView5.hidden = imageView6.hidden = NO;
        }
        

        
    }else{
        [_btLike setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
}
#pragma mark - Tap Event
- (void)tapLikeButton:(UIButton *)sender{
    BOOL isLike = !sender.selected;
    sender.selected = isLike;
    [self heartAnimation:isLike];
    if (isLike) {
       
        NSLog(@"点赞");
    }else{
        NSLog(@"取消赞");
    }
}
- (void)heartAnimation:(BOOL)toIsLike{
    UIImageView *heart = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 15.f, 15.f)];
    NSString *imageName = toIsLike ? @"like_hight" : @"like";
    heart.image = [UIImage imageNamed:imageName];
    CGPoint aPoint = CGPointMake(_btLike.center.x, _btLike.center.y);
    heart.center = aPoint;
    [self addSubview:heart];
    [UIView animateWithDuration:.5f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        heart.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        heart.center = aPoint;
        heart.alpha = 0.f;
    } completion:^(BOOL finished) {
        [heart removeFromSuperview];
    }];
    
}
- (void)tapOnAvatarView:(UITapGestureRecognizer *)aTap{
    UIView *tapView = aTap.view;
    
    NSInteger userIndex = -1;
    
    if ([tapView isEqual:imageView0]) {
        userIndex = 0;
    }else if ([tapView isEqual:imageView1]) {
        userIndex = 1;
    }else if ([tapView isEqual:imageView2]) {
        userIndex = 2;
    }else if ([tapView isEqual:imageView3]) {
        userIndex = 3;
    }else if ([tapView isEqual:imageView4]) {
        userIndex = 4;
    }else if ([tapView isEqual:imageView5]) {
        userIndex = 5;
    }else if ([tapView isEqual:imageView6]){
        userIndex = 6;
    }
    if (userIndex >= 0) {
//        WODUserModel *aUser = ((WDLikeItem *)likeUsers[userIndex]).likeUser;
        NSString * str = [NSString stringWithFormat:@"%ld",(long)userIndex];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
//        [self.delegate showDetailViewOfUser:@"aUser.id_str"];
    }
}


@end
