//
//  PETexttInputPanelView.h
//  Fabbi
//
//  Created by zou145688 on 16/6/8.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat kMinorHeight = 30.f;

@protocol WDMessagePannelViewDelegate <NSObject>

- (void)sendContent:(NSString *)pText;

@optional
- (void)updateFrameWithContentHeight:(CGFloat)pHeight;
@end
@interface PETexttInputPanelView : UIView
@property (nonatomic) CGFloat textContentHeight;
@property (nonatomic, strong) UITextView *commentTextView;
@property (nonatomic, weak) id <WDMessagePannelViewDelegate> delegate;
@end
