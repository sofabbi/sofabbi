//  DetailPageCell.h
//  MVP
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.

// 专题页面最上面
#import "BaseCell.h"
#import "DetailPageModel.h"
@protocol DetailPageDelegate<NSObject>
- (void)back;
- (void)getCell:(CGFloat)cellH;
@end

@interface DetailPageCell : BaseCell
// 最上面的图片
@property (nonatomic,strong) UIImageView *detailPageImageView;
// 图片，从上个页面传过来的
@property (nonatomic,strong)NSString *url;
// UIImageView上的label
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *descrLabel;

- (void)configDetailPageModel:(DetailPageModel *)detailPageModel;
// 代理
@property (nonatomic,strong)id<DetailPageDelegate>delegate;
// 返回按钮

+ (CGFloat)getAddTextAttributedLabel:(NSDictionary *)dic;
- (void)addTextAttributedLabel:(NSDictionary *)dic;
@end
