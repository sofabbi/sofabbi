//
//  RelatedProductsView.m
//  Fabbi
//
//  Created by zou145688 on 16/6/20.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "RelatedProductsView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation RelatedProductsView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
                _relatedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*kScreenWidthP, 0, 100*kScreenWidthP, 100*kScreenWidthP)];
        //        _relatedImageView.image = [UIImage imageNamed:@"123.png"];
                [self addSubview:_relatedImageView];
        
                _relatedtitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_relatedImageView.frame)+10*kScreenWidthP, 0, 150*kScreenWidthP, 37*kScreenWidthP)];
                _relatedtitle.numberOfLines = 2;
                _relatedtitle.textAlignment = NSTextAlignmentLeft;
                _relatedtitle.font = [UIFont systemFontOfSize:14];
                _relatedtitle.textColor = RGBA(34, 34, 34, 1);
                _relatedtitle.text = @"【NINA BRALETTE】\n运动胸罩";
                [self addSubview:_relatedtitle];
        
                _focusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_relatedImageView.frame)+19*kScreenWidthP, CGRectGetMaxY(_relatedtitle.frame)+25*kScreenWidthP, 15*kScreenWidthP, 13*kScreenWidthP)];
                [_focusImageView setImage:[UIImage imageNamed:@"fabbi_want"]];
                [self addSubview:_focusImageView];
        
                _focusNumberL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_focusImageView.frame)+4*kScreenWidthP, CGRectGetMinY(_focusImageView.frame), 150*kScreenWidthP, 14*kScreenWidthP)];
                _focusNumberL.textAlignment = NSTextAlignmentLeft;
                _focusNumberL.font = [UIFont systemFontOfSize:12];
                _focusNumberL.textColor = RGBA(34, 34, 34, 0.5);
                [self addSubview:_focusNumberL];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAddView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)setItemContenDic:(NSDictionary *)itemContenDic{
    _itemContenDic = itemContenDic;
    NSArray *itemFileList = [_itemContenDic objectForKey:@"itemFileList"];
    if (itemFileList.count > 0) {
        NSDictionary *dic = [itemFileList objectAtIndex:0];
        NSString *imageUrl = [dic objectForKey:@"fileUrl"];
        [_relatedImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }else{
        _relatedImageView.image = [UIImage imageNamed:@"placeholderImage"];
    }
    _relatedtitle.text = [_itemContenDic objectForKey:@"itemName"];
    
    NSString *numberStr = [NSString stringWithFormat:@"%@",[_itemContenDic objectForKey:@"loveSum"]];
    NSString *focusNumberStr = [NSString stringWithFormat:@"%@人想要",numberStr];
    _focusNumberL.text = focusNumberStr;
    if ([numberStr isEqualToString:@"0"]) {
        [_focusImageView setImage:[UIImage imageNamed:@"fabbi_want"]];
    }else{
        [_focusImageView setImage:[UIImage imageNamed:@"want-to"]];
    }
    
}
- (void)tapAddView{
    if (self.delegate) {
        [_delegate addFloatingView:_itemContenDic];
    }
}

@end
