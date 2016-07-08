//
//  MSSBrowseCollectionViewCell.h
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSBrowseLoadingImageView.h"
#import "MSSBrowseZoomScrollView.h"
@class MSSBrowseCollectionViewCell;

@protocol MSSBrowseCollectionViewCellDelegate <NSObject>

- (void)swipDownAction:(UISwipeGestureRecognizer *)swip currentView:(MSSBrowseCollectionViewCell *)currentView;


@end


typedef void(^MSSBrowseCollectionViewCellTapBlock)(MSSBrowseCollectionViewCell *browseCell);
typedef void(^MSSBrowseCollectionViewCellLongPressBlock)(MSSBrowseCollectionViewCell *browseCell);

typedef void(^MSSBrowseCollectionViewCellSwipBlock)(MSSBrowseCollectionViewCell *browseCell);
@interface MSSBrowseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)MSSBrowseZoomScrollView *zoomScrollView; // 滚动视图
@property (nonatomic,strong)MSSBrowseLoadingImageView *loadingView; // 加载视图
@property (nonatomic,weak)id<MSSBrowseCollectionViewCellDelegate>delegate;
- (void)tapClick:(MSSBrowseCollectionViewCellTapBlock)tapBlock;
- (void)longPress:(MSSBrowseCollectionViewCellLongPressBlock)longPressBlock;

@end
