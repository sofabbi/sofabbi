//
//  MineCollectionCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MineCollectionCell.h"
#import <TYAttributedLabel.h>
#import "UIImage+UIImageScale.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+ImageEffects.h"
@interface MineCollectionCell ()
@property (nonatomic, strong)UIImageView *aImageView;
@property (nonatomic, strong)UILabel *titleLable;
@end
@implementation MineCollectionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60.f*kScreenWidthP)];
//        _aImageView.backgroundColor = RGBA(0, 0, 0, 0.5);
        [_aImageView setContentMode:UIViewContentModeRedraw];
        [self addSubview:_aImageView];
        
        UIView *coverMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(_aImageView.frame))];
        coverMaskView.backgroundColor = RGBA(0, 0, 0, 0);
        [_aImageView addSubview:coverMaskView];
        
        
        UIImage *image = [UIImage coreBlurImage:[UIImage imageNamed:@"images.png"] withBlurNumber:5];
        UIImageView *ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60.f*kScreenWidthP)];
        ImageView.alpha = 0.5;
        ImageView.image = image;
        [_aImageView addSubview:ImageView];
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 19.f, kScreenWidth, 22.f)];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.text = @"return mineCell";
        [ImageView addSubview:_titleLable];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toGoodDetail)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)content:(MineCollectionModel *)model{
    _model = model;
    int width = (int)kScreenWidth;
    NSString *imageUrl =[NSString stringWithFormat:@"%@?imageView2/1/w/%d/h/60",model.specialLogoUrl,width];
    [_aImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _aImageView.image = [UIImage coreBlurImage:image withBlurNumber:1];
    }];
  
//    [_aImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    _titleLable.text = model.specialName;

}
- (void)toGoodDetail{
    if (self.delegate && _model) {
        [self.delegate toGoodDetail:_model];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
