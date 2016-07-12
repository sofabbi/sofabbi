//
//  CoverViewCollectionCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/12.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "CoverViewCollectionCell.h"
#import "UIView+Genie.h"
#import "UIImageView+WebCache.h"
@implementation CoverViewCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.imageView = [UIImageView new];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView setClipsToBounds:YES];
        [self.contentView addSubview:self.imageView];
        
        _detailView = [[UITextView alloc]init];
        _detailView.hidden = YES;
        _detailView.showsVerticalScrollIndicator = NO;
        _detailView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_detailView];
        
        self.selectedView=[[UIImageView alloc]init];
        [self.contentView addSubview:self.selectedView];
        _selectedView.userInteractionEnabled = YES;
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        [_selectBtn setBackgroundColor:RGBA(34, 34, 34, 0.8)];
        [_selectBtn setTitle:@"详情" forState:UIControlStateNormal];
        [_selectBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:13*kScreenWidthP];
        [_selectBtn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.layer.masksToBounds = YES;
        _selectBtn.layer.cornerRadius = 3*kScreenWidthP;
//        [_selectedView addSubview:_selectBtn];
//        [self.contentView bringSubviewToFront:_selectedView];
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSString *fileUrl = [dic objectForKey:@"fileUrl"];
    if (![NSString isBlankString:fileUrl]) {
      [_imageView sd_setImageWithURL:[NSURL URLWithString:fileUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }else{
        _imageView.image = [UIImage imageNamed:@"placeholderImage"];
    }
    
}
- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    if (_thumbnailImage != thumbnailImage) {
        _thumbnailImage = thumbnailImage;
        self.imageView.image = thumbnailImage;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.selectedView.frame=CGRectMake(self.contentView.bounds.size.width-70*kScreenWidthP, 0, 70*kScreenWidthP,50*kScreenWidthP);
    _selectBtn.frame=CGRectMake(3*kScreenWidthP, 14*kScreenWidthP,53*kScreenWidthP,21*kScreenWidthP);
    [self.imageView setFrame:self.contentView.bounds];
    _detailView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
 
}
-(void)btn_click:(UIButton*)sender

{
    BOOL selected = !sender.selected;
    sender.selected = selected;
    if (selected) {
        _detailView.hidden = NO;
    }else{
        _detailView.hidden = YES;
    }
    [self bringSubviewToFront:_selectedView];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(WDPhotosSelectCell:doQuickBtn:)])
//    {
//        [self.delegate WDPhotosSelectCell:self doQuickBtn:sender];
//    }
    
}
@end
