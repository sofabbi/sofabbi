//
//  DetailPageRelevantInformationCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "DetailPageRelevantInformationCell.h"
#import <TYAttributedLabel.h>
#define Start_X 5.0f*kScreenWidthP           // 第一个按钮的X坐标
#define Start_Y 10.0f*kScreenWidthP           // 第一个按钮的Y坐标
#define Width_Space 5.0f*kScreenWidthP        // 2个按钮之间的横间距
#define Height_Space 5.0f*kScreenWidthP      // 竖间距
#define Button_Height 124.0f*kScreenWidthP    // 高
#define Button_Width 180.0f*kScreenWidthP     // 宽
@interface DetailPageRelevantInformationCell ()<TYAttributedLabelDelegate>

@end
@implementation DetailPageRelevantInformationCell

+(CGFloat)getAddTextAttributedLabel:(NSString *)type{
    CGFloat height;
    type = @"2";
    if ([type isEqualToString:@"1"]) {
        TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        
        NSString *textp = @"";
        // 属性文本生成器
        TYTextContainer *attStringCreater = [[TYTextContainer alloc]init];
        attStringCreater.text = textp;
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            TYImageStorage*imageUrlStorage = [[TYImageStorage alloc]init];
            imageUrlStorage.size = CGSizeMake(kScreenWidth, 343*CGRectGetWidth(label.frame)/600);
            
            imageUrlStorage.imageAlignment = TYImageAlignmentFill;
            imageUrlStorage.margin = UIEdgeInsetsMake(10, 0, 0, 0);
            [tmpArray addObject:imageUrlStorage];
            
        }
        [attStringCreater addTextStorageArray:tmpArray];
        [attStringCreater createTextContainerWithTextWidth:kScreenWidth];
        label.textContainer = attStringCreater;
        [label sizeToFit];
        height = [label getHeightWithWidth:kScreenWidth];
    }else{
        NSInteger page = 5 / 2;
        height = page  * (Button_Height + Height_Space)+Start_Y + Button_Height;
    }
    
    
    
    height = height +19*kScreenWidthP+87*kScreenWidthP;
    TYAttributedLabel *textLable = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(20*kScreenWidthP, height, kScreenWidth-40*kScreenWidthP, 0)];
    textLable.linesSpacing = 22*kScreenWidthP;
    textLable.characterSpacing = 0.5*kScreenWidthP;
    NSString *text = @"该如何选择内衣?多教教佛奥降温费就安慰覅哦啊无金佛安静而佛教安二手房发煎熬我接收佛奥及佛教奥尔夫奇偶爱问金佛我按揭佛我骄傲饿哦if煎熬IE飞机哦艾薇附加费哇哦囧安静佛诶啊文静佛教啊我房价安违法及该如何选择内衣?多教教佛奥降温费就安慰覅哦啊无金佛安静而佛教安二手房发煎熬我接收佛奥及佛教奥尔夫奇偶爱问金佛我按揭佛我骄傲饿哦if煎熬IE飞机哦艾薇附加费哇哦囧安静佛诶啊文静佛教啊我房价安违法及该如何选择内衣?多教教佛奥降温费就安慰覅哦啊无金佛安静而佛教安二手房发煎熬我接收佛奥及佛教奥尔夫奇偶爱问金佛我按揭佛我骄傲饿哦if煎熬IE飞机哦艾薇附加费哇哦囧安静佛诶啊文静佛教啊我房价安违法及";
    // 属性文本生成器
    TYTextContainer *attString = [[TYTextContainer alloc]init];
    attString.text = text;
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:text];
    textStorage.textColor = RGBA(34, 34, 34, 1);
    textStorage.font = [UIFont systemFontOfSize:16];
    [attString addTextStorage:textStorage];
    
    [attString createTextContainerWithTextWidth:kScreenWidth-40*kScreenWidthP];
    textLable.textContainer = attString;
    [textLable sizeToFit];
    height = height + [textLable getHeightWithWidth:kScreenWidth-40*kScreenWidthP]+15*kScreenWidthP;
    return height;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //        [self addTextAttributedLabel:@"2"];
    }
    return self;
}

- (void)addTextAttributedLabel:(NSString *)type{
    CGFloat height;
    type = @"2";
    if ([type isEqualToString:@"1"]) {
        TYAttributedLabel *labelImageView = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        labelImageView.delegate = self;
        [self addSubview:labelImageView];
        // 属性文本生成器
        TYTextContainer *attStringCreater = [[TYTextContainer alloc]init];
        attStringCreater.text = @"";
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            TYImageStorage*imageUrlStorage = [[TYImageStorage alloc]init];
            imageUrlStorage.tag = i+101;
            imageUrlStorage.size = CGSizeMake(kScreenWidth, 343*CGRectGetWidth(labelImageView.frame)/600);
            
            imageUrlStorage.imageAlignment = TYImageAlignmentFill;
            imageUrlStorage.margin = UIEdgeInsetsMake(10, 5, 0, 5);
            [tmpArray addObject:imageUrlStorage];
            
        }
        [attStringCreater addTextStorageArray:tmpArray];
        [attStringCreater createTextContainerWithTextWidth:kScreenWidth];
        labelImageView.textContainer = attStringCreater;
        [labelImageView sizeToFit];
        height = [labelImageView getHeightWithWidth:kScreenWidth];
    }else{
        for (int i = 0 ; i < 5; i++) {
            NSInteger index = i % 2;
            NSInteger page = i / 2;
            
            
            UIButton *aBt = [UIButton buttonWithType:UIButtonTypeCustom];
            
            aBt.tag = i+101;
            [aBt addTarget:self action:@selector(tapImageAction:) forControlEvents:UIControlEventTouchUpInside];
            aBt.frame = CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
            [self addSubview:aBt];
        }
        NSInteger page = 5 / 2;
        height = page  * (Button_Height + Height_Space)+Start_Y + Button_Height;
    }
    
    CGFloat titleVY = height+17*kScreenWidthP;
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, titleVY, kScreenWidth, 22*kScreenWidthP)];
    titleView.backgroundColor = [UIColor clearColor];
    [self addSubview:titleView];
    UILabel *lineL = [[UILabel alloc]initWithFrame:CGRectMake(138*kScreenWidthP, 5*kScreenWidthP, 1, 12*kScreenWidthP)];
    lineL.backgroundColor = [UIColor blackColor];
    [titleView addSubview:lineL];
    UILabel *lineR = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-138*kScreenWidthP, 5*kScreenWidthP, 1, 12*kScreenWidthP)];
    lineR.backgroundColor = [UIColor blackColor];
    [titleView addSubview:lineR];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(140*kScreenWidthP, 0,kScreenWidth- 280*kScreenWidthP, 22*kScreenWidthP)];
    title.text = @"品牌世界";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:16];
    [titleView addSubview:title];
    
    UILabel *subtitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, titleVY+45*kScreenWidthP, kScreenWidth, 25*kScreenWidthP)];
    subtitleL.text = @"Olympia Activewear";
    subtitleL.font = [UIFont systemFontOfSize:18];
    subtitleL.textColor = [UIColor blackColor];
    subtitleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:subtitleL];
    CGFloat textLY = CGRectGetMaxY(subtitleL.frame) + 19*kScreenWidthP;
    TYAttributedLabel *textLable = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(20*kScreenWidthP, textLY, kScreenWidth-40*kScreenWidthP, 0)];
    textLable.delegate = self;
    [self addSubview:textLable];
    textLable.linesSpacing = 22*kScreenWidthP;
    textLable.characterSpacing = 0.5*kScreenWidthP;
    NSString *text = @"该如何选择内衣?多教教佛奥降温费就安慰覅哦啊无金佛安静而佛教安二手房发煎熬我接收佛奥及佛教奥尔夫奇偶爱问金佛我按揭佛我骄傲饿哦if煎熬IE飞机哦艾薇附加费哇哦囧安静佛诶啊文静佛教啊我房价安违法及该如何选择内衣?多教教佛奥降温费就安慰覅哦啊无金佛安静而佛教安二手房发煎熬我接收佛奥及佛教奥尔夫奇偶爱问金佛我按揭佛我骄傲饿哦if煎熬IE飞机哦艾薇附加费哇哦囧安静佛诶啊文静佛教啊我房价安违法及该如何选择内衣?多教教佛奥降温费就安慰覅哦啊无金佛安静而佛教安二手房发煎熬我接收佛奥及佛教奥尔夫奇偶爱问金佛我按揭佛我骄傲饿哦if煎熬IE飞机哦艾薇附加费哇哦囧安静佛诶啊文静佛教啊我房价安违法及";
    // 属性文本生成器
    TYTextContainer *attString = [[TYTextContainer alloc]init];
    attString.text = text;
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:text];
    textStorage.textColor = RGBA(34, 34, 34, 1);
    textStorage.font = [UIFont systemFontOfSize:16];
    [attString addTextStorage:textStorage];
    
    [attString createTextContainerWithTextWidth:kScreenWidth-40*kScreenWidthP];
    textLable.textContainer = attString;
    [textLable sizeToFit];
    
}
// 点击代理
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point{
    if ([textStorage isKindOfClass:[TYImageStorage class]]) {
        TYImageStorage *imageStorage = (TYImageStorage *)textStorage;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:[NSString stringWithFormat:@"你点击了%ld图片",(long)imageStorage.tag] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }else if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {
        
        id linkStr = ((TYLinkTextStorage*)textStorage).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:linkStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
}
- (void)tapImageAction:(UIButton *)sender{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:[NSString stringWithFormat:@"你点击了%ld图片",(long)sender.tag] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
