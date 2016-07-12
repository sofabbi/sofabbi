
//  DetailPageCell.m
//  MVP
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.

#import "DetailPageCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtils.h"
#import <TYAttributedLabel.h>
#import <DTCoreText/DTCoreText.h>
@interface DetailPageCell ()<TYAttributedLabelDelegate>
@property (nonatomic, weak) TYAttributedLabel *label;
@property (nonatomic, strong) TYImageStorage *imageUrlStorage;
@property (nonatomic, strong) DTAttributedLabel *lable;
@end
@implementation DetailPageCell

+ (CGFloat)getAddTextAttributedLabel:(NSDictionary *)dic{
    CGFloat height= 87*kScreenWidthP;
    DTAttributedLabel*lable = [[DTAttributedLabel alloc] initWithFrame: CGRectMake(20*kScreenWidthP, 0*kScreenWidthP, kScreenWidth-40*kScreenWidthP, FLT_MAX)];
    NSString * htmlcontent =  [dic objectForKey:@"itemContens"];
    lable.attributedString = [DetailPageCell _attributedStringForSnippetUsingiOS6Attributes:NO html:htmlcontent];
    [lable sizeToFit];
    [lable relayoutText];
    height += lable.frame.size.height;
    return height;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailPageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 258*kScreenWidthP)];
        //        [self addSubview:self.detailPageImageView];
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20*kScreenWidthP, 20*kScreenWidthP, kScreenWidth - 40*kScreenWidthP, 28*kScreenWidthP)];
        _titleLable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
        _titleLable.textColor = RGBA(34, 34, 34, 1);
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLable];
        
        _lable = [[DTAttributedLabel alloc] initWithFrame: CGRectMake(20*kScreenWidthP, 0*kScreenWidthP, kScreenWidth-40*kScreenWidthP, FLT_MAX)];
        _label.backgroundColor = [UIColor redColor];
        [self addSubview:_lable];
        
    }
    return  self;
}

- (void)addTextAttributedLabel:(NSDictionary *)dic{
    NSArray *itemFileList = [dic objectForKey:@"itemFileList"];
    if (itemFileList.count > 0) {
        NSDictionary *itemFileListDic = [itemFileList objectAtIndex:0];
        NSString *imageUrl = [itemFileListDic objectForKey:@"fileUrl"];
        [_detailPageImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }
    _titleLable.text = [dic objectForKey:@"itemName"];
    NSString *htmlStr = [dic objectForKey:@"itemContens"];
    _lable.attributedString = [DetailPageCell _attributedStringForSnippetUsingiOS6Attributes:NO html:htmlStr];
    [_lable sizeToFit];
    _lable.frame = CGRectMake(20*kScreenWidthP, CGRectGetMaxY(_titleLable.frame)+20*kScreenWidthP, kScreenWidth - 40*kScreenWidthP, _lable.frame.size.height);
    
}


+ (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes html:(NSString *)htmlStr
{
    // Load HTML data
    
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake(kScreenWidth - 20.0, kScreenHeight - 20.0);
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, [NSNumber numberWithFloat:16],DTDefaultFontSize ,[NSNumber numberWithInt:NSTextAlignmentJustified],DTDefaultTextAlignment,@"PingFangSC-Light",DTDefaultFontName,[NSNumber numberWithFloat:1.4],DTDefaultLineHeightMultiplier,nil];
    
    if (useiOS6Attributes)
    {
        [options setObject:[NSNumber numberWithBool:YES] forKey:DTUseiOS6Attributes];
    }
    
    [options setObject:htmlStr forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    
    return string;
}

- (void)configDetailPageModel:(DetailPageModel *)detailPageModel{
    NSURL *url = [NSURL URLWithString:self.url];
    _imageUrlStorage.imageURL = url;
    [self.detailPageImageView sd_setImageWithURL:url];
}

@end
