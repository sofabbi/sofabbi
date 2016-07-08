//
//  ImageViewCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/21.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "ImageViewCell.h"
#import <TYAttributedLabel.h>
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define Start_X 5.0f*kScreenWidthP           // 第一个按钮的X坐标
#define Start_Y 10.0f*kScreenWidthP           // 第一个按钮的Y坐标
#define Width_Space 5.0f*kScreenWidthP        // 2个按钮之间的横间距
#define Height_Space 5.0f*kScreenWidthP      // 竖间距
#define Button_Height 124.0f*kScreenWidthP    // 高
#define Button_Width 180.0f*kScreenWidthP// 宽


#define BStart_X 10.0f*kScreenWidthP           // 第一个按钮的X坐标
#define BStart_Y 15.0f*kScreenWidthP           // 第一个按钮的Y坐标
#define BWidth_Space 5.0f*kScreenWidthP        // 2个按钮之间的横间距
#define BHeight_Space 10.0f*kScreenWidthP      // 竖间距
#define BButton_Height 244.0f*kScreenWidthP    // 高
#define BButton_Width kScreenWidth - 20*kScreenWidthP// 宽

@interface ImageViewCell ()<TYAttributedLabelDelegate>
@property (nonatomic,strong)NSArray *itemFileLists;
@end
@implementation ImageViewCell
+(CGFloat)getAddTextAttributedLabel:(NSDictionary *)dic{
    CGFloat height;
   NSString *type = @"1";
    NSArray *itemFileList = [dic objectForKey:@"itemFileList"];
    if (itemFileList.count > 0) {
        if ([type isEqualToString:@"1"]) {
            NSInteger count= itemFileList.count;
            height = BStart_Y + count * BButton_Height+(count - 1)*BHeight_Space;
        }else{
            NSInteger page = (itemFileList.count -1)/ 2;
            height = page  * (Button_Height + Height_Space)+Start_Y + Button_Height;
        }
        height = height;
        return height;
    }else{
        return 0;
    }
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}
- (void)addTextAttributedLabel:(NSDictionary *)dic{
    CGFloat height;
   NSString *type = @"1";
    _itemFileLists = [dic objectForKey:@"itemFileList"];
    if (_itemFileLists.count > 0) {
        if ([type isEqualToString:@"1"]) {
            for (NSInteger i = 0; i < _itemFileLists.count; i++) {
                NSDictionary *imageDic = [_itemFileLists objectAtIndex:i];
                NSString *imageUrl = [imageDic objectForKey:@"fileUrl"];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(BStart_X , i  * (BButton_Height + BHeight_Space)+BStart_Y, BButton_Width, BButton_Height)];
                imageView.tag = i+201;
                [self addSubview:imageView];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
                [imageView addGestureRecognizer:tapImage];
                if (![NSString isBlankString:imageUrl]) {
                  [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
                }else{
                    [imageView setImage:[UIImage imageNamed:@"placeholderImage"]];
                }
            }
           
        }else{
            for (int i = 0 ; i < _itemFileLists.count; i++) {
//                NSDictionary *imageDic = [itemFileList objectAtIndex:i];
//                NSString *imageUrl = [imageDic objectForKey:@"fileUrl"];
                NSInteger index = i % 2;
                NSInteger page = i / 2;
                UIButton *aBt = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [aBt setImage:[UIImage imageNamed:@"123.png"] forState:UIControlStateNormal];
                aBt.tag = i+101;
                [aBt addTarget:self action:@selector(tapImageAction:) forControlEvents:UIControlEventTouchUpInside];
                aBt.frame = CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
                [self addSubview:aBt];
            }
            NSInteger page = 5 / 2;
            height = page  * (Button_Height + Height_Space)+Start_Y + Button_Height;
        }
  
    }
    
}
// 点击代理
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point{
    if ([textStorage isKindOfClass:[TYImageStorage class]]) {
//        TYImageStorage *imageStorage = (TYImageStorage *)textStorage;

    }else if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {
        
        id linkStr = ((TYLinkTextStorage*)textStorage).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {
            
        }
    }
}
- (void)tapImageAction:(UITapGestureRecognizer*)sender {
    
    UIImageView *imageView =(UIImageView *)sender.view;
//    [self.delegate selectImageView:imageView];
    [self.delegate selectImageView:imageView itemFileLists:_itemFileLists];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
