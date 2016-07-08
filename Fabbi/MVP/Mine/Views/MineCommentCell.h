//
//  MineCommentCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"
#import "MineCommentModel.h"

@protocol mineCommentCellDelegate <NSObject>
- (void)toDetailOrGood:(MineCommentModel *)model;

@end
@interface MineCommentCell : BaseCell
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) MineCommentModel *model;
@property (nonatomic,weak)id<mineCommentCellDelegate>delegate;
+(CGFloat)getCellHeight:(MineCommentModel *)model;
- (void)addTextAttributedLabel:(MineCommentModel *)model;
@end
