//
//  FlowView.h
//  MVP
//
//  Created by 刘志刚 on 16/5/16.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUtils.h"

@protocol flowViewDelegate <NSObject>
- (void)comment;
- (void)want:(BOOL)isLike sucess:(void (^)(id responseObject))sucess failure:(void(^)(NSError *error))failure;
- (void)toLink;
- (void)tologin;

@end
@interface FlowView : UIView
@property (nonatomic,strong)UIButton *myCommitBtn;
@property (nonatomic,strong)UIButton *starBtn;
@property (nonatomic,strong)UIButton *toLinkBtn;
@property (nonatomic,strong)NSString *from;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,weak)id<flowViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame from:(NSString *)from;
- (void)Dic:(NSDictionary *)dic;
@end
