//
//  FirstPageSpecialCell.h
//  MVP
//  Created by 刘志刚 on 16/4/22.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"
#import "FirstPageModel.h"

@interface FirstPageSpecialCell : BaseCell
// 最上面的图片
@property (nonatomic,strong) UIImageView *firPageImageView;
// 图片下面的view
@property (nonatomic,strong) UIView *whiteView;
// 该如何选内衣label
@property (nonatomic,strong) UILabel *firPageLeftLabel;
// 涨知识label
@property (nonatomic,strong) UILabel *firPageRightLabel;
// 最上面的图片
//@property (nonatomic,strong) UIImageView *firIconImageView;

- (void)configfirstPageModel:(FirstPageModel *)firstPageModel;

@end
