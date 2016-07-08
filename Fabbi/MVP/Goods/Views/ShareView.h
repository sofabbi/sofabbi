//
//  ShareView.h
//  Fabbi
//
//  Created by zou145688 on 16/6/12.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WDSocialShareType) {
    WDSHARE_WEIXIN = 33,
    WDSHARE_FRIEND_CIRCLE,
    WDSHARE_SINA,
    WDSHARE_QQ_ZONE,
    EXTRA_BTN_REPORT,
    EXTRA_BTN_DELETE,
    EXTRA_BTN_RENAME
    
};

@class ShareView;
@protocol ShareViewDelegate <NSObject>

-(void)didSelectedItem:(UIButton *)sender;
//-(void)WDShareView:(ShareView *)shareView didSelectedItem:(UIButton *)sender;

@end
@interface ShareView : UIView

@property (nonatomic, weak) id <ShareViewDelegate> delegate;


//如果按钮不需要高亮， index 给负值 例如 -1
- (id)initWithCanBeShared:(BOOL)canBeShared buttonTitles:(NSArray *)items stylizeButtonIndex:(NSInteger)index andDelegate:(id)pDelegate;
//- (id)initCallMyFriendWithButtonTitles:(NSArray *)items stylizeButtonIndex:(NSInteger)index andDelegate:(id)pDelegate;
- (void)showInView:(UIView *)pView;
@end
