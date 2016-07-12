
//  SingleGoodsCell.m
//  MVP
//  Created by 刘志刚 on 16/4/22.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "SingleGoodsCell.h"
#import "MyUtils.h"
#import "UIImageView+WebCache.h"


@implementation SingleGoodsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.signleGoodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*kScreenWidthP, 10*kScreenWidthP, kScreenWidth-20*kScreenWidthP, 200*kScreenWidthP)];
        [self.contentView addSubview:self.signleGoodsImageView];
        
        self.signleGoodsLabel = [MyUtils createLabelFrame:CGRectMake(10*kScreenWidthP, 210*kScreenWidthP,kScreenWidth-20*kScreenWidthP, 120*kScreenWidthP) title:@"我这边重点就是两个地方，下单有时候不成功大白看看，然后配送这边看看" font:15 textAlignment:NSTextAlignmentLeft textColor: RGBA(0, 0, 0, 1) backgroundColor:RGBA(255, 255, 255, 1) numberOfLines:0 layerCornerRadius:0.f];
        [self.contentView addSubview:self.signleGoodsLabel];
        
        
        // 相关商品view
        UIView *goodView = [[UIView alloc]initWithFrame:CGRectMake(0, 330*kScreenWidthP, kScreenWidth, 280*kScreenWidthP)];
        goodView.backgroundColor = RGBA(255, 255, 255, 1);
        // 线
        UILabel *labelA = [MyUtils createLabelFrame:CGRectMake(30*kScreenWidthP, 25*kScreenWidthP, 70*kScreenWidthP, 1) backgroundColor:RGBA(215, 215, 215, 1) title:nil font:0.f];
        [goodView addSubview:labelA];
        
        UILabel *labelB = [MyUtils createLabelFrame:CGRectMake(kScreenWidth - 100*kScreenWidthP, 25*kScreenWidthP, 70*kScreenWidthP, 1) backgroundColor:RGBA(215, 215, 215, 1) title:nil font:0.f];
        [goodView addSubview:labelB];
        
        UILabel *labelC = [MyUtils createLabelFrame:CGRectMake(kScreenWidth/2 - 50*kScreenWidthP, 10*kScreenWidthP, 100*kScreenWidthP, 30*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"相关商品" font:15];
        labelC.textAlignment = NSTextAlignmentCenter;
        
        [goodView addSubview:labelC];
        [self.contentView addSubview:goodView];
        
        // _firgoodLabel里面有imageview和button
        _firgoodLabel = [MyUtils createLabelFrame:CGRectMake(0, 40*kScreenWidthP, kScreenWidth, 120*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:nil font:0.f];
        [goodView addSubview:_firgoodLabel];
        
        
        _firgoodImageView = [MyUtils createImageViewFrame:CGRectMake(30*kScreenWidthP, 10*kScreenWidthP, 90*kScreenWidthP, 90*kScreenWidthP) imageName:nil  cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_firgoodLabel addSubview:_firgoodImageView];
        
        
        _firgoodnameLabel = [MyUtils createLabelFrame:CGRectMake(150*kScreenWidthP, 10*kScreenWidthP, 80*kScreenWidthP, 30*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"邱成的衣服"font:12.0f];
        [_firgoodLabel addSubview:_firgoodnameLabel];
        
        UIImageView *commImageView = [MyUtils createImageViewFrame:CGRectMake(150*kScreenWidthP, 45*kScreenWidthP, 20*kScreenWidthP, 20*kScreenWidthP) imageName:@"Imported Layers Copy 8" cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_firgoodLabel addSubview:commImageView];
        
        UILabel *commLabel = [MyUtils createLabelFrame:CGRectMake(180*kScreenWidthP, 43*kScreenWidthP, 30*kScreenWidthP, 20*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"120"font:12.0f];
        [_firgoodLabel addSubview:commLabel];
        
        UIImageView *loveImageView = [MyUtils createImageViewFrame:CGRectMake(230*kScreenWidthP, 45*kScreenWidthP, 20*kScreenWidthP, 20*kScreenWidthP) imageName:@"Imported Layers Copy 5" cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_firgoodLabel addSubview:loveImageView];
        
        UILabel *loveLabel = [MyUtils createLabelFrame:CGRectMake(260*kScreenWidthP, 43*kScreenWidthP, 30*kScreenWidthP, 20*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"250"font:12.0f];
        [_firgoodLabel addSubview:loveLabel];
        
        UIImageView *nextImageView = [MyUtils createImageViewFrame:CGRectMake(kScreenWidth-40*kScreenWidthP, 48*kScreenWidthP, 10*kScreenWidthP, 10*kScreenWidthP) imageName:@"Group 10" cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_firgoodLabel addSubview:nextImageView];
        
        
        
        // label2
        _secgoodLabel = [MyUtils createLabelFrame:CGRectMake(0, 160*kScreenWidthP, kScreenWidth, 120*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:nil font:0.f];
        [goodView addSubview:_secgoodLabel];
        
        _secgoodImageView = [MyUtils createImageViewFrame:CGRectMake(30*kScreenWidthP, 10*kScreenWidthP, 90*kScreenWidthP, 90*kScreenWidthP) imageName:nil  cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_secgoodLabel addSubview:_secgoodImageView];
        
        _firgoodnameLabel = [MyUtils createLabelFrame:CGRectMake(150*kScreenWidthP, 10*kScreenWidthP, 80*kScreenWidthP, 30*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"邱成的裤子"font:12.0f];
        [_secgoodLabel addSubview:_firgoodnameLabel];
        
        UIImageView *commImageViewB = [MyUtils createImageViewFrame:CGRectMake(150*kScreenWidthP, 45*kScreenWidthP, 20*kScreenWidthP, 20*kScreenWidthP) imageName:@"Imported Layers Copy 8" cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_secgoodLabel addSubview:commImageViewB];
        
        UILabel *commLabelB = [MyUtils createLabelFrame:CGRectMake(180*kScreenWidthP, 43*kScreenWidthP, 30*kScreenWidthP, 20*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"120"font:12.0f];
        [_secgoodLabel addSubview:commLabelB];
        
        UIImageView *loveImageViewB = [MyUtils createImageViewFrame:CGRectMake(230*kScreenWidthP, 45*kScreenWidthP, 20*kScreenWidthP, 20*kScreenWidthP) imageName:@"Imported Layers Copy 5" cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_secgoodLabel addSubview:loveImageViewB];
        
        UILabel *loveLabelB = [MyUtils createLabelFrame:CGRectMake(260*kScreenWidthP, 43*kScreenWidthP, 30*kScreenWidthP, 20*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"250"font:12.0f];
        [_secgoodLabel addSubview:loveLabelB];
        
        UIImageView *nextImageViewB = [MyUtils createImageViewFrame:CGRectMake(kScreenWidth-40*kScreenWidthP, 48*kScreenWidthP, 10*kScreenWidthP, 10*kScreenWidthP) imageName:@"Group 10" cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
        [_secgoodLabel addSubview:nextImageViewB];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firgoodsTapGesture:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [goodView addGestureRecognizer:tap];
    }
    return self;
}

// 弹出浮层
- (void)firgoodsTapGesture:(UITapGestureRecognizer *)tap{
    [self.delegate addFloatingView];
    
}

- (void)configSingleGoodPageModel:(SingleGoodsModel *)SingleGoodsModel{
    // 上面的大图片
    NSURL *url = [NSURL URLWithString:self.url];
    [self.signleGoodsImageView sd_setImageWithURL:url];
    [self.firgoodImageView sd_setImageWithURL:url];
    
    NSURL *url1 = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/622762d0f703918f15e87fcb533d269759eec4f2.jpg"];
    [self.secgoodImageView sd_setImageWithURL:url1];
    
}
@end
