//
//  CommentCell.m
//  MVP
//
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "CommentCell.h"
#import "MyUtils.h"
#import <TYAttributedLabel.h>
#import "NSDate+Time.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface CommentCell ()<TYAttributedLabelDelegate>
@property (nonatomic, strong)TYAttributedLabel *textLable;
@property (nonatomic, strong)TYTextContainer *attString;
@end
@implementation CommentCell
+(CGFloat)getAddTextAttributedLabel:(CommentModel*)model{
    CGFloat cellH;
    cellH = 75.f*kScreenWidthP;
    TYAttributedLabel *textLable = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(84*kScreenWidthP, 75*kScreenWidthP, kScreenWidth-104*kScreenWidthP, 0)];
    
    textLable.linesSpacing = 22*kScreenWidthP;
    textLable.characterSpacing = 0.5*kScreenWidthP;
    NSString *text = model.commentContens;
    // 属性文本生成器
    TYTextContainer *attString = [[TYTextContainer alloc]init];
    attString.text = text;
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:text];
    textStorage.textColor = RGBA(34, 34, 34, 1);
    textStorage.font = [UIFont systemFontOfSize:16];
    [attString addTextStorage:textStorage];
    
    [attString createTextContainerWithTextWidth:kScreenWidth-104*kScreenWidthP];
    textLable.textContainer = attString;
    [textLable sizeToFit];
    CGFloat textH = cellH + [textLable getHeightWithWidth:kScreenWidth-104*kScreenWidthP]+15*kScreenWidthP;
    cellH = textH;
    return cellH;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       self.commentImageView = [MyUtils createImageViewFrame:CGRectMake(20*kScreenWidthP, 20*kScreenWidthP, 47*kScreenWidthP, 47*kScreenWidthP) imageName:@"Avatar_default" cornerRadius:47/2*kScreenWidthP clipsToBounds:YES userInteractionEnabled:YES];
        [self.contentView addSubview:self.commentImageView];
        
        self.nameLabel = [MyUtils createLabelFrame:CGRectMake(84*kScreenWidthP, 20*kScreenWidthP, 120*kScreenWidthP, 20*kScreenWidthP)  title:@"名称名称名称" font:15.0f textAlignment:NSTextAlignmentLeft textColor:RGBA(34,34,34,0.8) backgroundColor:[UIColor whiteColor] numberOfLines:0 layerCornerRadius:0.f];
        _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15*kScreenWidthP];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.timeLabel = [MyUtils createLabelFrame:CGRectMake(84*kScreenWidthP, 47*kScreenWidthP, 110*kScreenWidthP, 17*kScreenWidthP)  title:@"今天  16:40" font:13.0f textAlignment:NSTextAlignmentLeft textColor:RGBA(0,0,0,0.8) backgroundColor:[UIColor whiteColor] numberOfLines:0 layerCornerRadius:0.f];
        _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13*kScreenWidthP];
        [self.contentView addSubview:self.timeLabel];
        
        _textLable = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(84*kScreenWidthP, 75*kScreenWidthP, kScreenWidth-104*kScreenWidthP, 0)];
        _textLable.delegate = self;
        [self addSubview:_textLable];
        _textLable.linesSpacing = 22*kScreenWidthP;
        _textLable.characterSpacing = 0.5*kScreenWidthP;
        
    }
    return self;
}
- (void)addTextAttributedLabel:(CommentModel *)model{
    
    [NSDate timtimeStr:@"2016-5-20 00:00:01"];
    [_commentImageView sd_setImageWithURL:[NSURL URLWithString:model.userLogo] placeholderImage:[UIImage imageNamed:@"Avatar_default"]];
    NSString *timeStr = model.createTimeStr;
    _timeLabel.text = [NSDate timtimeStr:timeStr];
    
    NSString *text = model.commentContens;
    // 属性文本生成器
    TYTextContainer *attString = [[TYTextContainer alloc]init];
    attString.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*kScreenWidthP];
    attString.text = text;
    attString.textAlignment = kCTTextAlignmentJustified;
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:text];
    textStorage.textColor = RGBA(34, 34, 34, 0.6);
    [attString addTextStorage:textStorage];
    
    [attString createTextContainerWithTextWidth:kScreenWidth-104*kScreenWidthP];
    _textLable.textContainer = attString;
    [_textLable sizeToFit];
    _nameLabel.text = model.userName;
}

@end
