//
//  MineCollectionCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"
#import "MineCollectionModel.h"

@protocol mineCollectionCellDelegate <NSObject>

- (void)toGoodDetail:(MineCollectionModel *)model;

@end
@interface MineCollectionCell : BaseCell
@property (nonatomic,strong)MineCollectionModel *model;
@property (nonatomic,weak)id<mineCollectionCellDelegate>delegate;
- (void)content:(MineCollectionModel *)model;

@end
