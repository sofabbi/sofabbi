//
//  CommentCell.h
//  MVP
//
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.

//专题页面的评论cell
#import "BaseCell.h"
#import "CommentModel.h"
@interface CommentCell : BaseCell
 //左边的图片


@property (nonatomic,strong) UIImageView *commentImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *descLabel;
+(CGFloat)getAddTextAttributedLabel:(CommentModel*)model;
- (void)addTextAttributedLabel:(CommentModel *)model;
@end
