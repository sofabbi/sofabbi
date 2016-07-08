//
//  LinkView.h
//  MVP
//
//  Created by 刘志刚 on 16/5/11.
//  Copyright © 2016年 刘志刚. All rights reserved.
 

#import <UIKit/UIKit.h>

@protocol LinkViewDelegate <NSObject>
- (void)comment;
- (void)want:(BOOL)isLike sucess:(void (^)(id responseObject))sucess failure:(void(^)(NSError *error))failure;
- (void)toLink;
- (void)tologin;

@end
// 直达链接View
@interface LinkView : UIView
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UIButton *commitBtn;
@property (nonatomic,strong)UIButton *loveBtn;
@property (nonatomic,strong)UIButton *toLinkBtn;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,weak)id<LinkViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame isShowCommit:(BOOL)isShow;
@end
