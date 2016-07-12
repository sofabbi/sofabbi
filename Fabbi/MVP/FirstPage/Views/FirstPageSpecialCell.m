
//  FirstPageSpecialCell.m
//  MVP
//  Created by 刘志刚 on 16/4/22.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "FirstPageSpecialCell.h"
#import "MyUtils.h"
#import "UIImageView+WebCache.h"

@implementation FirstPageSpecialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.firPageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*kScreenWidthP, 0, kScreenWidth-20*kScreenWidthP, 245*kScreenWidthP)];
        [_firPageImageView setContentMode:UIViewContentModeRedraw];
        [self.contentView addSubview:self.firPageImageView];
        
        self.whiteView = [MyUtils createViewFrame:CGRectMake(10*kScreenWidthP,245*kScreenWidthP, kScreenWidth-20*kScreenWidthP, 60*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 1)];
        [self.contentView addSubview:self.whiteView];
        
        self.firPageLeftLabel = [MyUtils createLabelFrame:CGRectMake(25*kScreenWidthP,(245+18)*kScreenWidthP,kScreenWidth - 50*kScreenWidthP, 25*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 1) title:@"该如何选择内衣？" font:18*kScreenWidthP];
        self.firPageLeftLabel.textColor = RGBA(34, 34, 34, 1);
        self.firPageLeftLabel.font = [UIFont systemFontOfSize:18*kScreenWidthP];
        [self.contentView addSubview:self.firPageLeftLabel];
        
        self.firPageRightLabel = [MyUtils createLabelFrame:CGRectMake(297*kScreenWidthP,265*kScreenWidthP, 53*kScreenWidthP, 22*kScreenWidthP) title:nil font:13*kScreenWidthP textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] backgroundColor:RGBA(67, 181, 223, 1) numberOfLines:1 layerCornerRadius:3*kScreenWidthP];
        self.firPageRightLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13*kScreenWidthP];
        _firPageRightLabel.hidden = YES;
        self.firPageRightLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:self.firPageRightLabel];
    }
    return  self;
}

- (void)configfirstPageModel:(FirstPageModel *)firstPageModel{
    
    NSString *googType =[NSString stringWithFormat:@"%@",firstPageModel.goodsType];
    if ([googType isEqualToString:@"1"]) {
        NSArray *itemFileList = [firstPageModel.firstItemVoModel objectForKey:@"itemFileList"];
        if (![NSArray isBlankArray:itemFileList]) {
            NSDictionary *dic = [itemFileList objectAtIndex:0];
            NSString *imageUrl = [dic objectForKey:@"fileUrl"];
            if (![NSString isBlankString:imageUrl]) {
                //                int width = (int)(kScreenWidth-20*kScreenWidthP);
                //                int height = (int)245*kScreenWidthP;
                //                NSString * imageurl = [NSString stringWithFormat:@"%@?imageView2/1/w/%d/h/%d",imageUrl,width,height];
                NSURL *url = [NSURL URLWithString:imageUrl];
                [self.firPageImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
                [_firPageImageView setNeedsDisplay];
            }else{
                _firPageImageView.image = [UIImage imageNamed:@"placeholderImage"];
            }
            
        }
        self.firPageLeftLabel.text = [firstPageModel.firstItemVoModel objectForKey:@"itemName"];
        
    }else if([googType isEqualToString:@"2"]){
        NSString *str= [firstPageModel.firstSpecialVoModel objectForKey:@"specialLogoUrl"];
        if (![NSString isBlankString:str]) {
            NSURL *url = [NSURL URLWithString:str];
            [self.firPageImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        }else{
            _firPageImageView.image = [UIImage imageNamed:@"placeholderImage"];
        }
        self.firPageLeftLabel.text = [firstPageModel.firstSpecialVoModel objectForKey:@"specialName"];
    }
}

@end
