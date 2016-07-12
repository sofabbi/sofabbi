//
//  MSSBrowseCollectionViewCell.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "MSSBrowseCollectionViewCell.h"
#import "MSSBrowseDefine.h"

@interface MSSBrowseCollectionViewCell ()

@property (nonatomic,copy)MSSBrowseCollectionViewCellTapBlock tapBlock;
@property (nonatomic,copy)MSSBrowseCollectionViewCellLongPressBlock longPressBlock;
@property (nonatomic,copy)MSSBrowseCollectionViewCellSwipBlock swipBlock;

@end

@implementation MSSBrowseCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _zoomScrollView = [[MSSBrowseZoomScrollView alloc]init];
    __weak __typeof(self)weakSelf = self;
    [_zoomScrollView tapClick:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.tapBlock(strongSelf);
    }];
    [self.contentView addSubview:_zoomScrollView];
    
    _loadingView = [[MSSBrowseLoadingImageView alloc]init];
    [_zoomScrollView addSubview:_loadingView];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [self.contentView addGestureRecognizer:longPressGesture];
    UISwipeGestureRecognizer *swipUPGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipUPGesture.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.contentView addGestureRecognizer:swipUPGesture];
    
    
    UISwipeGestureRecognizer *swipDownGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.contentView addGestureRecognizer:swipDownGesture];
}
//轻扫手势触发方法
-(void)swipeGesture:(id)sender
{
    
    UISwipeGestureRecognizer *swipe = sender;
    [self.delegate swipDownAction:swipe currentView:self];
}

- (void)tapClick:(MSSBrowseCollectionViewCellTapBlock)tapBlock
{
    _tapBlock = tapBlock;
}

- (void)longPress:(MSSBrowseCollectionViewCellLongPressBlock)longPressBlock
{
    _longPressBlock = longPressBlock;
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if(_longPressBlock)
    {
        if(gesture.state == UIGestureRecognizerStateBegan)
        {
            _longPressBlock(self);
        }
    }
}

@end
