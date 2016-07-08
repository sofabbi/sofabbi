//  SingleGoodsCell.h
//  MVP
//  Created by 刘志刚 on 16/4/22.
//  Copyright © 2016年 刘志刚. All rights reserved.

// 专题页面中间的商品
#import "BaseCell.h"
#import "SingleGoodsModel.h"

@protocol SingGoodDelegate <NSObject>
- (void)addFloatingView;
@end

@interface SingleGoodsCell : BaseCell
@property (nonatomic,strong) UIImageView *signleGoodsImageView;
@property (nonatomic,strong) UILabel *signleGoodsLabel;
@property (nonatomic,strong) NSString *url;
// 相关商品1以及里面的内容
@property (nonatomic,strong) UILabel *firgoodLabel;
@property (nonatomic,strong) UIImageView *firgoodImageView;
@property (nonatomic,strong) UIImageView *secgoodImageView;
@property (nonatomic,strong) UILabel *firgoodnameLabel;
@property (nonatomic,strong) UILabel *secondnameLabel;

// 相关商品2
@property (nonatomic,strong)UILabel *secgoodLabel;
- (void)configSingleGoodPageModel:(SingleGoodsModel *)SingleGoodsModel;
@property (nonatomic,strong) id<SingGoodDelegate>delegate;
@end
