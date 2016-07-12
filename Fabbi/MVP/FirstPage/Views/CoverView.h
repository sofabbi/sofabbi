//
//  CoverView.h
//  MVP
//
//  Created by 刘志刚 on 16/5/11.
//  Copyright © 2016年 刘志刚. All rights reserved.
//
// 专题覆盖DetailPageView
#import <UIKit/UIKit.h>
#import "LinkView.h"

@protocol CoverViewDelegate <NSObject>

- (void)tologin;

@end
@interface CoverView : UIView<LinkViewDelegate>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LinkView *linkView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSDictionary *contenDic;

@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextView *detailTextView;
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, weak) id<CoverViewDelegate>delegate;

@end
