//
//  CoverViewCollectionCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/12.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoverViewCollectionCell;

@protocol CoverViewCollectionCellDelegate <NSObject>

-(void)WDPhotosSelectCell:(CoverViewCollectionCell *)cell doQuickBtn:(UIButton *)btn;

@end
@interface CoverViewCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong)  UIImageView *imageView;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextView *detailView;
@property (nonatomic, strong) NSDictionary *dic;

@property (assign, nonatomic) BOOL isShow;
@property (nonatomic, weak) id<CoverViewCollectionCellDelegate>delegate;
@end
