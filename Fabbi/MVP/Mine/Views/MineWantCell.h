//
//  MineWantCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"
#import "MineCollectionModel.h"
@protocol  mineWantCellDelegate<NSObject>

-(void)favorAblumTapped:(MineCollectionModel *)groupItem;

@end
@interface MineWantCell : BaseCell
@property (nonatomic, weak) id <mineWantCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)NSArray *contentArr;
- (void)setContent:(NSArray *)itemsGroup atIndexPath:(NSIndexPath *)indexPath;
@end
