//
//  MineCommentCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/6.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MineCommentCell.h"
#import <TYAttributedLabel.h>
#import "NSDate+Time.h"
#define CommentW 312.f
#define CommentY 18.f
@interface MineCommentCell ()<TYAttributedLabelDelegate>
@property (nonatomic, strong) UILabel *fromTitleL;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) TYAttributedLabel *label;
@end
@implementation MineCommentCell
+(CGFloat)getCellHeight:(MineCommentModel *)model{
    CGFloat cellH;
    TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(20.f*kScreenWidthP, CommentY*kScreenWidthP, CommentW*kScreenWidthP, 0)];
    
    NSString *text = model.commentContens;
    // 属性文本生成器
    TYTextContainer *attStringCreater = [[TYTextContainer alloc]init];
    attStringCreater.text = text;
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:text];
    textStorage.textColor = RGBA(213, 0, 0, 1);
    textStorage.font = [UIFont systemFontOfSize:14];
    [attStringCreater addTextStorage:textStorage];
    [attStringCreater createTextContainerWithTextWidth:CommentW*kScreenWidthP];
    label.textContainer = attStringCreater;
    [label sizeToFit];
    
    CGFloat lableH = [label getHeightWithWidth:CommentW*kScreenWidthP];
    cellH = lableH+18*kScreenWidthP+14*kScreenWidthP+10*kScreenWidthP+21*kScreenWidthP;
   
    return cellH;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addTextAttributedLabel:_model];
        _label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(20.f*kScreenWidthP, 18.f*kScreenWidthP, CommentW*kScreenWidthP, 0)];
        _label.delegate = self;
        [self.contentView addSubview:_label];
        CGFloat Y = CGRectGetMaxY(_label.frame)+14*kScreenWidthP;
        _fromTitleL = [self creatLable:CGRectMake(10.f*kScreenWidthP, Y, kScreenWidth-127*kScreenWidthP, 21*kScreenWidthP) font:15 textAlignment:NSTextAlignmentLeft];
        [self addSubview:_fromTitleL];
        _timeL = [self creatLable:CGRectMake(kScreenWidth-167*kScreenWidthP, Y, 150*kScreenWidthP, 21*kScreenWidthP) font:13 textAlignment:NSTextAlignmentRight];
        [self addSubview:_timeL];
        self.contentView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)addTextAttributedLabel:(MineCommentModel *)model{
    
    _model = model;
    NSString *text = model.commentContens;
    // 属性文本生成器
    TYTextContainer *attStringCreater = [[TYTextContainer alloc]init];
    attStringCreater.textAlignment = kCTTextAlignmentJustified;
    attStringCreater.text = text;
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:text];
    textStorage.textColor = RGBA(34, 34, 34, 1);
    textStorage.font = [UIFont systemFontOfSize:14];
    [attStringCreater addTextStorage:textStorage];
    [attStringCreater createTextContainerWithTextWidth:CommentW*kScreenWidthP];
    _label.textContainer = attStringCreater;
    [_label sizeToFit];
    CGFloat h = CGRectGetMaxY(_label.frame)+14*kScreenWidthP;
    _fromTitleL.frame = CGRectMake(10.f*kScreenWidthP, h, kScreenWidth-127*kScreenWidthP, 21*kScreenWidthP);
  _timeL.frame = CGRectMake(kScreenWidth-167*kScreenWidthP, h, 150*kScreenWidthP, 21*kScreenWidthP);
    NSString *name = model.itemName ? model.itemName:model.specialName;
    _fromTitleL.text = [NSString stringWithFormat:@"《%@》",name];
    NSString *timeStr = model.createTimeStr;
    _timeL.text = [NSDate timtimeStr:timeStr];

}
- (UILabel *)creatLable:(CGRect)frame font:(CGFloat)font textAlignment:(NSTextAlignment)Alignment{
    UILabel *lable = [[UILabel alloc]initWithFrame:frame];
    lable.font = [UIFont systemFontOfSize:font];
    lable.textColor = RGBA(186, 186, 186, 1);
    lable.textAlignment = Alignment;
    return lable;
}
-(void)toDetail{
    [self.delegate toDetailOrGood:_model];
}

@end
