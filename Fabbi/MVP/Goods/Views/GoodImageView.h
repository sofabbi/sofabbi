//
//  GoodImageView.h
//  MVP
//
//  Created by 刘志刚 on 16/5/17.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GoodImageDelegate<NSObject>
- (void)backFirstPageVctrl;
@end
@interface GoodImageView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *imgArray;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger pageNumber;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) id<GoodImageDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imgArr;
@end
